require 'net/http'
require 'json'
require 'uri'

module OpenAIWrapper
  def self.call_api(messages:, is_json_output: true)
    uri = URI('https://api.openai.com/v1/chat/completions')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(
      uri.path, {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['AUTOGITC_KEY']}"
      }
    )

    body = { model: 'gpt-4o-mini', messages: messages }
    body.merge!(response_format: { "type": 'json_object' }) if is_json_output
    request.body = body.to_json

    response = http.request(request)
    result = JSON.parse(response.body)
    result.dig('choices', 0, 'message', 'content')
  end
end
