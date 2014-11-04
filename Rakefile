require 'bundler/gem_tasks'

namespace :test do
  task :env do
    $LOAD_PATH.unshift('lib', 'spec')
  end

  desc 'Runs only the specs in this project'
  task :specs => [:env] do
    Dir.glob('./spec/**/*_spec.rb') { |f| require f }
  end

  desc 'Runs all of the tests within this project'
  task :all => [:specs]
end

desc 'Runs all of the tests within this project'
task :test => 'test:all'
task :default => :test
