require 'skeleton/schema'
require 'skeleton/header'

module Skeleton
  class Response < Schema
    attr_accessor :summary, :description

    alias_method :summarize, :summary=
    alias_method :describe, :description=

    def headers
      @headers ||= {}
    end

    def no_body
      @schema = nil
    end

    def schema?
      !!@schema
    end

    def schema(value=nil, &block)
      if block
        @schema = Skeleton::Model.new
        @schema.instance_eval(&block)
      elsif value.is_a?(Hash)
        @schema = Skeleton::Schema.new(value)
      end

      @schema
    end

    def header(field, options={})
      headers[field] = Skeleton::Header.new(options)
    end
  end
end
