require 'skeleton/model'

module Skeleton
  class SecurityRequirement < Model
    def initialize(args={})
      @requirements = []
      args.each { |name, value| set(name, value) }
    end

    def get(name)
      @requirements[name]
    end
    alias_method :[], :get

    def set(name, value)
      @requirements[name] = Array(value)
    end
    alias_method :[]=, :set

    def to_h
      hash = {}
      @requirements.each do |name, definition|
        hash[name] = definition
      end
      hash
    end
    alias_method :to_swagger_hash, :to_h
  end
end
