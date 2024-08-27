# autogen_git_commit

This is a Ruby gem that automates the process of generating Git commit messages using AI.

<i><b>Fun Fact</b>: Every commit in this project (except the very first one) was generated using the AI-powered commit message generator in this code!</i>

## More About This Tool

- This gem uses OpenAI's GPT-4o Mini model, which is cost-effective but requires an internet connection and an API key. Currently, the model is hardcoded.
- It has no dependencies, making it easy to install and integrate into projects without conflicts.

## Installation

Install it yourself as:

```
$ gem install autogen_git_commit
```

## Usage

To use autogen_git_commit in your project, follow these steps:

1. Add the following line to your Gemfile under the development group to prevent loading the gem by default:

   ```ruby
   gem 'autogen_git_commit', require: false
   ```

2. Ensure that your OpenAI API key is set in the environment variable `AUTOGITC_KEY`.

3. After installation, add some files to your Git repository:

   ```
   $ git add .
   ```

4. Trigger the autogen_git_commit process using:

   ```
   $ bundle exec rake autogitc
   ```

   This will analyze your changes and generate an AI-powered commit message. It will be committed with the generated message.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adriangohjw/autogen_git_commit.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
