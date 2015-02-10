require 'skeleton/schema'

module Skeleton
  class Items < Schema
    attr_reader :items, :collection_format

    def items=(value)
      case value
      when Hash
        @items = Skeleton::Items.new(value)
      else
        @items = value
      end
    end

    def collection_format
      return nil unless array?

      if @collection_format.nil?
        'csv'
      else
        @collection_format
      end
    end

    def collection_format=(value)
      @collection_format = value.to_s
    end

    def items?
      !!@items
    end
  end
end
