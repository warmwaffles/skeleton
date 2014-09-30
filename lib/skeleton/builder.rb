require 'skeleton/action'
require 'skeleton/link'

module Skeleton
  class Builder
    attr_accessor :actions

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

    def to_h
      hash = {
        links: []
      }
      @actions.each do |verb, action|
        hash.store(verb.to_s.upcase, action.to_h)
      end
      @links.each do |rel, link|
        hash['links'] = link.to_h
      end
      hash
    end
    alias_method :to_hash, :to_h
  end
end
