require 'skeleton/operation'

module Skeleton
  class Path
    attr_reader :operations

    def initialize
      @operations = Hash.new
    end

    def head(&block)
      operation(:head, &block)
    end

    def head?
      @operations.key?(:head)
    end

    def get(&block)
      operation(:get, &block)
    end

    def get?
      @operations.key?(:get)
    end

    def put(&block)
      operation(:put, &block)
    end

    def put?
      @operations.key?(:put)
    end

    def post(&block)
      operation(:post, &block)
    end

    def post?
      @operations.key?(:post)
    end

    def patch(&block)
      operation(:patch, &block)
    end

    def patch?
      @operations.key?(:patch)
    end

    def delete(&block)
      operation(:delete, &block)
    end

    def delete?
      @operations.key?(:delete)
    end

    def options(&block)
      operation(:options, &block)
    end

    def options?
      @operations.key?(:options)
    end

    def operation(type, &block)
      @operations[type] = Skeleton::Operation.new
      @operations[type].instance_eval(&block)
      @operations[type]
    end
  end
end
