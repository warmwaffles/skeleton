require 'skeleton/operation'
require 'skeleton/parameter'

module Skeleton
  class Path
    attr_accessor :ref
    attr_reader :operations
    attr_reader :parameters

    def initialize(args={})
      @operations = args[:operations] || {}
      @parameters = Array(args[:parameters])
      @ref        = args[:ref]
    end

    def parameter(location, name, &block)
      param = Skeleton::Parameter.new({name: name})
      yield(param) if block
      @parameters << param
    end

    def get(&block)
      define_operation(:get, &block)
    end

    def put(&block)
      define_operation(:put, &block)
    end

    def post(&block)
      define_operation(:post, &block)
    end

    def delete(&block)
      define_operation(:delete, &block)
    end

    def options(&block)
      define_operation(:options, &block)
    end

    def head(&block)
      define_operation(:head, &block)
    end

    def patch(&block)
      define_operation(:patch, &block)
    end

    private

    def define_operation(method, &block)
      operation = Skeleton::Operation.new
      yield(operation) if block
      @operations[method] = operation
    end
  end
end
