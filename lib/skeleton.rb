require 'skeleton/version'
require 'skeleton/builder'

module Skeleton
  def self.build(&block)
    builder = Builder.new
    yield(builder) if block
    builder
  end
end
