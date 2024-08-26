require 'net/http'
require 'json'
require 'uri'

def openai_api_key
  ENV['OPENAI_API_KEY']
end

def get_staged_files
  `git diff --name-only --staged`.split("\n")
end

def get_file_diff(file_path)
  `git diff --staged #{file_path}`
end

def generate_commit_message(changes_summary)
  uri = URI("https://api.openai.com/v1/chat/completions")
  
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  
  request = Net::HTTP::Post.new(uri.path, {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{openai_api_key}"
  })
  
  request.body = {
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: "You are a helpful assistant that generates concise and semantic git commit messages." },
      { role: "user", content: "Generate a conventional git commit message limited to 72 characters for the following changes in a JSON format with a key 'commit_message':\n\n#{changes_summary}" }
    ],
    response_format: { "type": 'json_object' }
  }.to_json
  
  response = http.request(request)
  result = JSON.parse(response.body)
  output_text = result.dig("choices", 0, "message", "content")
  JSON.parse(output_text).dig('commit_message')
end

def main
  if openai_api_key.nil?
    puts "No OPENAI_API_KEY key found in environment variables."
    return
  end

  staged_files = get_staged_files

  if staged_files.empty?
    puts "No files are staged for commit."
    return
  end

  changes_summary = staged_files.map do |file|
    diff = get_file_diff(file)
    "Changes in #{file}:\n#{diff}\n"
  end.join("\n")

  commit_message = generate_commit_message(changes_summary)
  puts "Generated commit message:\n#{commit_message}"

  # Optionally, commit with the generated message
  `git commit -m "#{commit_message}"`
end

main
