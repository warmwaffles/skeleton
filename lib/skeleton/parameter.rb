module Skeleton
  class Parameter
    attr_accessor :name, :location, :description, :required, :schema, :type,
                  :format, :items, :collection_format, :default, :maximum,
                  :exclusive_maximum, :minimum, :exclusive_minimum, :max_length,
                  :min_length, :unique_items, :multiple_of, :min_items,
                  :max_items, :pattern

    attr_writer :enum

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.public_send(setter, v) if self.respond_to?(setter)
      end
    end

    def enum
      @enum ||= []
    end

    def pattern?
      !!@pattern
    end

    def multiple_of?
      !!@multiple_of
    end

    def enum?
      !enum.empty?
    end

    def unique_items?
      !!@unique_items
    end

    def max_items?
      !!@max_items
    end

    def min_items?
      !!@min_items
    end

    def min_length?
      !!@min_length
    end

    def max_length?
      !!@max_length
    end

    def minimum?
      !!@minimum
    end

    def maximum?
      !!@maximum
    end

    def default?
      !!@default
    end

    def collection_format?
      !!@collection_format
    end

    def items?
      !!@items
    end

    def format?
      !!@format
    end

    def type?
      !!@type
    end

    def schema?
      !!@schema
    end

    def required?
      !!@required
    end

    def description?
      !!@description
    end

    def location?
      !!@location
    end

    def name?
      !!@name
    end

    def exclusive_maximum?
      !!@exclusive_maximum
    end

    def exclusive_minimum?
      !!@exclusive_minimum
    end

    def unique_items?
      !!@unique_items
    end

    def array?
      @type == 'array'
    end

    def string?
      @type == 'string'
    end

    def number?
      @type == 'number'
    end

    def integer?
      @type == 'integer'
    end

    def boolean?
      @type == 'boolean'
    end

    def file?
      @type == 'file'
    end
  end
end
