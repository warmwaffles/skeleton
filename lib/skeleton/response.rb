require 'skeleton/attributes'

module Skeleton
  class Response
    extend Skeleton::Attributes

    attr_accessor :description, :schema, :headers, :examples
    attr_presence :descriptions, :schema, :headers, :examples

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
  end
end
