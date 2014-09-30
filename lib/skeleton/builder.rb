require 'skeleton/action'
require 'skeleton/link'

module Skeleton
  class Builder
    def initialize
      @actions = Hash.new
      @links = Hash.new
    end

    def define(verb, options={}, &block)
      action = Action.new
      yield(action) if block
      @actions.store(verb.to_s.downcase, action)
      Array(options[:also]).each { |v| define(v, &block) }
    end

    def link(args={})
      raise(ArgumentError, ':rel is required') unless args[:rel]
      raise(ArgumentError, ':href is required') unless args[:href]

      @links.store(args[:rel], Link.new(args))
    end
  end
end
