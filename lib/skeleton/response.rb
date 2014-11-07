require 'skeleton/model'
require 'skeleton/headers'
require 'skeleton/schema'

module Skeleton
  class Response < Model
    attr_accessor :description
    attr_reader :headers, :schema
    attr_presence :descriptions, :examples
    attr_not_empty :headers, :schema

    def headers=(value)
      case value
      when Hash
        @headers = Skeleton::Headers.new(value)
      else
        @headers = value
      end
    end

    def schema=(value)
      case value
      when Hash
        @schema = Skeleton::Schema.new(value)
      else
        @schema = value
      end
    end

    def examples=(value)
      case value
      when Hash
        @examples = Skeleton::Example.new(value)
      else
        @examples = value
      end
    end

    def to_h
      hash = {}
      hash[:description] = description   if description?
      hash[:examples]    = examples.to_h if examples?
      hash[:headers]     = headers.to_h  if headers?
      hash[:schema]      = schema.to_h   if schema?
      hash[:examples]    = examples.to_h if examples?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:description] = description              if description?
      hash[:examples]    = examples.to_swagger_hash if examples?
      hash[:headers]     = headers.to_swagger_hash  if headers?
      hash[:schema]      = schema.to_swagger_hash   if schema?
      hash[:examples]    = examples.to_swagger_hash if examples?
      hash
    end
  end
end
