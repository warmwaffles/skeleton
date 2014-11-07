require 'skeleton/operation'
require 'skeleton/parameter'
require 'skeleton/model'

module Skeleton
  class Path < Model
    attr_accessor :ref
    attr_writer :operations
    attr_not_empty :parameters, :operations

    def operations
      @operations ||= {}
    end

    def parameters=(value)
      @parameters = Array(value)
    end

    def parameters
      @parameters ||= []
    end

    def parameter(location, name, &block)
      param = Skeleton::Parameter.new({name: name})
      yield(param) if block
      parameters << param
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

    def to_h
      hash = {}
      if operations?
        operations.each do |method, operation|
          if operation.respond_to?(:to_h)
            hash[method] = operation.to_h
          else
            hash[method] = operation
          end
        end
      end
      if parameters?
        hash[:parameters] = parameters.map do |parameter|
          if parameter.respond_to?(:to_h)
            parameter.to_h
          else
            parameter
          end
        end
      end
      hash
    end

    def to_swagger_hash
      hash = {}
      if operations?
        operations.each do |method, operation|
          if operation.respond_to?(:to_swagger_hash)
            hash[method] = operation.to_swagger_hash
          else
            hash[method] = operation
          end
        end
      end
      if parameters?
        hash[:parameters] = parameters.map do |parameter|
          if parameter.respond_to?(:to_swagger_hash)
            parameter.to_swagger_hash
          else
            parameter
          end
        end
      end
      hash
    end

    private

    def define_operation(method, &block)
      operation = Skeleton::Operation.new
      yield(operation) if block
      operations[method] = operation
    end
  end
end
