require 'bundler/gem_tasks'

namespace :test do
  task :env do
    $LOAD_PATH.unshift('lib', 'test')
  end

  desc 'Runs only the specs in this project'
  task :specs => [:env] do
    Dir.glob('./test/**/*_spec.rb') { |f| require f }
  end

  desc 'Runs only the test units in this project'
  task :units => [:env] do
    Dir.glob('./test/**/*_test.rb') { |f| require f }
  end

  desc 'Runs all of the tests within this project'
  task :all => [:env] do
    Dir.glob('./test/**/*_{spec,test}.rb') { |f| require f }
  end
end

desc 'Runs all of the tests within this project'
task :test => 'test:all'
task :default => :test
