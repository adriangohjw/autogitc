# Start of Selection

require_relative 'lib/autogitc'

namespace :autogitc do
  desc 'Trigger autogitc'
  task :run do
    puts 'Running autogitc...'
    Autogitc.main
  end
end

task autogitc: 'autogitc:run'
task default: 'autogitc:run'
