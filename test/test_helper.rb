require 'rubygems'
require 'bundler'
require 'pp'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

require 'webmock/minitest'

module Minitest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

require_relative 'support/fixtures'
require_relative 'support/kissmetrics/core_api'
require_relative 'support/factories/structure_factory'
