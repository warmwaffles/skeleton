require 'skeleton/parameter'

module Skeleton
  class Parameters
    include Enumerable

    def initialize
      @list = []
    end

    def empty?
      @list.empty?
    end

    def each(&block)
      @list.each(&block)
    end

    def get(name)
      find { |p| p.name == name }
    end
    alias_method :[], :get

    def add(parameter)
      @list << parameter
      parameter
    end

    def required(name, args={})
      opts = args.merge(name: name, required: true)
      add(Skeleton::Parameter.new(opts))
    end

    def optional(name, args={})
      opts = args.merge(name: name, required: false)
      add(Skeleton::Parameter.new(opts))
    end
    alias_method :param, :optional
  end
end
