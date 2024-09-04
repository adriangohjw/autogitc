# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'autogitc'
  s.version       = '0.3.1'
  s.summary       = 'Auto-generate Git commit messages with LLM'
  s.description   = 'This gem simplifies the commit process by automatically generating descriptive commit messages based on the files that have been added to the Git staging area. It leverages LLM to analyze the changes and create meaningful commit messages, helping you maintain a clean and organized commit history.'
  s.authors       = ['Adrian Goh']
  s.email         = 'hello@adriangohjw.com'
  s.files         = Dir.glob('lib/**/*') + Dir.glob('lib/*')
  s.require_paths = ['lib']
  s.executables   = ['autogitc']
  s.bindir        = 'bin'
  s.homepage      = 'https://github.com/adriangohjw/autogitc'
  s.license       = 'MIT'
  s.required_ruby_version = '>= 3.0.0'
end
