# autogitc

This is a Ruby gem that automates the process of generating Git commit messages using AI.

<i><b>Fun Fact</b>: Every commit in this project (except the very first one) was generated using the AI-powered commit message generator in this code!</i>

## More About This Tool

- This gem uses OpenAI's GPT-4o Mini model, which is cost-effective but requires an internet connection and an API key. Currently, the model is hardcoded.
- It has no dependencies, making it easy to install and integrate into projects without conflicts.

## Installation

1. Add the following line to your Gemfile under the development group to prevent loading the gem by default:

   ```ruby
   group :development do
      gem 'autogitc'
   end
   ```

2. Run `bundle install`

3. Ensure that your OpenAI API key is set in the environment variable `AUTOGITC_KEY`.

## Usage

### Generate git commit messages

1. Add some files to your Git repository:

   ```
   $ git add .
   ```

2. Trigger the autogitc process using:

   ```
   $ bundle exec autogitc
   ```

   This will analyze your changes and generate an AI-powered commit message. It will be committed with the generated message.

#### More Options

- Use `--nc` (or `--nocommit`) to get the generated commit message without making a commit.
- Use `--text=XXX` to specify a required text that should be included in the generated commit message. Replace `XXX` with your desired text.

### Generate PR from template (Experimental)

The PR template generator will create a template for your pull request.

```
$ bundle exec autogitc pr
```

- Specify the base branch using `--base=BRANCH_NAME` (default is `main` if not specified).
- The generator will search for the template file in the following locations (in order):
  - `/project/pull_request_template.md`
  - `/project/docs/pull_request_template.md`
  - `/project/.github/pull_request_template.md`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adriangohjw/autogitc.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
