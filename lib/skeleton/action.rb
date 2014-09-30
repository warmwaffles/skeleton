require 'skeleton/parameter'

module Skeleton
  class Action
    attr_accessor :description

    def initialize
      @parameters = {}
    end

    def param(name, &block)
      parameter = Parameter.new
      yield(parameter) if block
      @parameters.store(name, parameter)
    end

    def example(&block)
    end
  end
end
