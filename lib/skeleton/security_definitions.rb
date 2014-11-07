require 'skeleton/model'
require 'skeleton/security_scheme'

module Skeleton
  class SecurityDefinitions < Model
    def initialize(args={})
      @schemes = {}
      args.each { |k, v| set(k, v) }
    end

    def get(name)
      @schemes[name]
    end
    alias_method :[], :get

    def set(name, value)
      case value
      when Hash
        @schemes[name] = Skeleton::SecurityScheme.new(value)
      else
        @schemes[name] = value
      end
    end
    alias_method :[]=, :set

    def empty?
      !@schemes.empty?
    end

    def to_h
      hash = {}
      @schemes.each do |name, scheme|
        hash[name] = scheme.to_h
      end
      hash
    end

    def to_swagger_hash
      hash = {}
      @schemes.each do |name, scheme|
        hash[name] = scheme.to_swagger_hash
      end
      hash
    end
  end
end
