require 'json'
require_relative 'openai_wrapper'

module PrTemplateGenerator
  # refer to https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository
  def self.template_paths
    filename = 'pull_request_template.md'
    [
      File.join(Dir.pwd, filename),
      File.join(Dir.pwd, 'docs', filename),
      File.join(Dir.pwd, '.github', filename)
    ]
  end

  def self.template_path_where_file_is_found
    template_paths.each do |path|
      return path if File.exist?(path)
    end
    nil
  end

  def self.output_path
    File.join(Dir.pwd, "pull_request_template_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.md")
  end

  def self.branch_name
    `git rev-parse --abbrev-ref HEAD`.strip
  end

  def self.commits(base_branch:)
    `git log --oneline #{base_branch}..HEAD`.strip
  end

  def self.template_content
    File.read(template_path_where_file_is_found)
  end

  def self.generate_filled_template(base_branch:)
    output = OpenAIWrapper.call_api(
      messages: [
        {
          role: 'system',
          content: 'You are a helpful assistant that generates filled pull request templates based on provided templates and context.'
        },
        {
          role: 'user',
          content: <<~PROMPT
            Please fill out the following pull request template as closely as possible using the branch name '#{branch_name}' and the following commits:
            #{commits(base_branch: base_branch)}

            Template enclosed in ``` below:
            ```
            #{template_content}
            ```

            Ensure the output closely resembles the provided template.
            Be succinct in the content.
            Return only the filled template without any additional comments.
          PROMPT
        }
      ],
      is_json_output: false
    )
    output.strip.gsub(/^```|```$/, '')
  end

  def self.main(base_branch:)
    if template_path_where_file_is_found.nil?
      puts 'Pull request template not found.'
      puts 'Template should be found at:'
      template_paths.each { |path| puts " - #{path}" }
      return
    end

    filled_template = generate_filled_template(base_branch: base_branch)

    File.write(output_path, filled_template)
    puts "Filled pull request template created at #{output_path}."
  end
end
