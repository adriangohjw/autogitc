# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'autogitc'
  s.version       = '0.1.3'
  s.summary       = 'Auto-generate Git commit messages with LLM'
  s.description   = 'This gem simplifies the commit process by automatically generating descriptive commit messages based on the files that have been added to the Git staging area. It leverages LLM to analyze the changes and create meaningful commit messages, helping you maintain a clean and organized commit history.'
  s.authors       = ['Adrian Goh']
  s.email         = 'hello@adriangohjw.com'
  s.files         = ['lib/autogitc.rb']
  s.require_paths = ['lib']
  s.executables   = ['autogitc']
  s.bindir        = 'bin'
  s.homepage      = 'https://github.com/adriangohjw/autogitc'
  s.license       = 'MIT'
end
