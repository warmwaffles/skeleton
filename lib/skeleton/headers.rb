require 'skeleton/model'
require 'skeleton/header'

module Skeleton
  class Headers < Model
    def initialize(args={})
      @fields = {}
      args.each { |k, v| set(k, v)}
    end

    def get(name)
      @fields[name]
    end
    alias_method :[], :get

    def set(name, value)
      case value
      when Hash
        @fields[name] = Skeleton::Header.new(value)
      else
        @fields[name] = value
      end
    end
    alias_method :[]=, :set

    def to_h
      hash ={}
      @fields.each do |name, value|
        if value.respond_to?(:to_h)
          hash[name] = value.to_h
        else
          hash[name] = value
        end
      end
      hash
    end

    def to_swagger_hash
      hash ={}
      @fields.each do |name, value|
        if value.respond_to?(:to_swagger_hash)
          hash[name] = value.to_swagger_hash
        else
          hash[name] = value
        end
      end
      hash
    end
  end
end
