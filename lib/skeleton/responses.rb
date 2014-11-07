require 'skeleton/model'
require 'skeleton/response'

module Skeleton
  class Responses < Model
    attr_accessor :default
    attr_presence :default

    def initialize(args={})
      @responses = {}
      args.each { |k, v| set(k, v) }
    end

    def get(code)
      @responses[code]
    end
    alias_method :[], :get

    def set(code, value)
      case value
      when Hash
        @responses[code] = Skeleton::Response.new(value)
      else
        @responses[code] = value
      end
    end
    alias_method :[]=, :set

    def empty?
      @responses.empty?
    end

    def to_h
      hash = {}
      hash[:default] = default.to_h if default?
      @responses.each do |code, response|
        if response.respond_to?(:to_h)
          hash[code] = response.to_h
        else
          hash[code] = response
        end
      end
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:default] = default.to_h if default?
      @responses.each do |code, response|
        if response.respond_to?(:to_swagger_hash)
          hash[code] = response.to_swagger_hash
        else
          hash[code] = response
        end
      end
      hash
    end
  end
end
