module Skeleton
  class Response
    attr_accessor :description, :schema, :headers, :examples

    def initialize(args={})
      @description = args[:description]

      case args[:schema]
      when Hash
        @schema = Skeleton::Schema.new(args[:schema])
      else
        @schema = args[:schema]
      end

      case args[:headers]
      when Hash
        @headers = Skeleton::Headers.new(args[:headers])
      else
        @headers = args[:headers]
      end

      @examples = args[:examples]
    end

    def description?
      !!@description
    end

    def schema?
      !!@schema
    end

    def headers?
      !!@headers
    end

    def examples?
      !!@examples
    end
  end
end
