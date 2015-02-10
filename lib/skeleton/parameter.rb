require 'skeleton/schema'
require 'skeleton/items'

module Skeleton
  class Parameter < Schema
    attr_reader :name, :location, :items, :schema

    def items?
      !!@items
    end

    def items=(hash)
      self.type = 'array'
      @items = Skeleton::Items.new(hash)
    end
    alias_method :array=, :items=

    def schema?
      !!@schema
    end

    def schema=(value)
      case value
      when Hash
        @schema = Skeleton::Schema.new(value)
      else
        @schema = value
      end
    end

    def name=(value)
      @name = value.to_s
    end

    def location=(value)
      @location = value.to_s
    end

    def body?
      @location == 'body'
    end

    def query?
      @location == 'query'
    end

    def path?
      @location == 'path'
    end

    def header?
      @location == 'header'
    end
  end
end
