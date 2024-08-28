require 'net/http'
require 'json'
require 'uri'

module Autogitc
  def self.openai_api_key
    ENV['AUTOGITC_KEY']
  end

  def self.get_staged_files
    `git diff --name-only --staged`.split("\n")
  end

  def self.get_file_diff(file_path)
    `git diff --staged #{file_path}`
  end

  def self.generate_commit_message(changes_summary:, must_have_text: nil)
    uri = URI('https://api.openai.com/v1/chat/completions')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(
      uri.path, {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{openai_api_key}"
      }
    )

    request.body = {
      model: 'gpt-4o-mini',
      messages: [
        {
          role: 'system',
          content: 'You are a helpful assistant that generates concise and semantic git commit messages.'
        },
        {
          role: 'user',
          content: "Generate a conventional git commit message limited to 72 characters for the following changes in a JSON format with a key 'commit_message', ensuring it includes the text: '#{must_have_text}':\n\n#{changes_summary}"
        }
      ],
      response_format: { "type": 'json_object' }
    }.to_json

    response = http.request(request)
    result = JSON.parse(response.body)
    output_text = result.dig('choices', 0, 'message', 'content')
    JSON.parse(output_text)['commit_message']
  end

  def self.main(no_commit: false, must_have_text: nil)
    if openai_api_key.nil?
      puts 'No AUTOGITC_KEY key found in environment variables.'
      return
    end

    staged_files = get_staged_files

    if staged_files.empty?
      puts 'No files are staged for commit.'
      return
    end

    changes_summary = staged_files.map do |file|
      diff = get_file_diff(file)
      "Changes in #{file}:\n#{diff}\n"
    end.join("\n")

    commit_message = generate_commit_message(
      changes_summary: changes_summary,
      must_have_text: must_have_text
    )
    puts 'Generated commit message:'
    puts commit_message

    `git commit -m "#{commit_message}"` unless no_commit
  end
end
