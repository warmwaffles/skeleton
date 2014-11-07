require 'skeleton/model'

module Skeleton
  class Scopes < Model
    attr_reader :scopes

    def initialize
      @scopes = {}
    end

    def [](name)
      @scopes[name]
    end

    def []=(name, description)
      @scopes[name] = description
    end

    def to_h
      @scopes
    end
    alias_method :to_swagger_hash, :to_h
  end
end
