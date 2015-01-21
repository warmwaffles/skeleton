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
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test

if Gem::Specification::find_all_by_name('rails').any?
  APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
  load 'rails/tasks/engine.rake'
end
