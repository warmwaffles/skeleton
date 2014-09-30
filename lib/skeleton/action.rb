require 'skeleton/parameter'
require 'skeleton/example'
require 'skeleton/link'

module Skeleton
  class Action
    attr_accessor :description, :links, :examples, :parameters

    def initialize
      @parameters = Hash.new
      @examples = Array.new
      @links = Hash.new
    end

    def param(name, &block)
      parameter = Parameter.new
      yield(parameter) if block
      @parameters.store(name.to_s, parameter)
    end

    def example(&block)
      example = Example.new
      yield(example) if block
      @examples.push(example)
    end

    def link(args={})
      raise(ArgumentError, ':rel is required') unless args[:rel]
      raise(ArgumentError, ':href is required') unless args[:href]

      @links.store(args[:rel], Link.new(args))
    end

    def to_h
      hash = {
        'description' => description,
        'parameters' => Hash.new,
        'links' => links.map { |_,link| link.to_h },
        'examples' => examples.map(&:to_h)
      }
      parameters.each { |n, p| hash['parameters'].store(n, p.to_h) }
      hash
    end
    alias_method :to_hash, :to_h
  end
end
