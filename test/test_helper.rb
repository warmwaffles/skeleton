require 'rubygems'
require 'bundler'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

module Minitest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative 'support/kissmetrics/core_api'
require_relative 'support/fixtures'
