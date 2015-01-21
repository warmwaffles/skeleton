require 'rubygems'
require 'bundler'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

if skeleton_rails?
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
  Rails.backtrace_cleaner.remove_silencers!

  require 'rails/test_help'
  require 'minitest/rails'
end

module Minitest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end
