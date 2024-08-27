# Start of Selection

require 'autogitc'

namespace :autogitc do
  desc 'Trigger autogitc'
  task :run do
    puts 'Running autogitc...'
    Autogitc.main
  end

  desc 'Trigger autogitc via bundle exec'
  task :trigger do
    Rake::Task['autogitc:run'].invoke
  end
end
# End of Selection
