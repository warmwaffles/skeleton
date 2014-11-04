module Skeleton
  class Item
    attr_accessor :type, :format, :title, :description, :default, :multiple_of,
                  :maximum, :exclusive_maximum, :minimum, :exclusive_minimum,
                  :max_length, :min_length, :pattern, :max_items, :min_items,
                  :unique_items, :max_properties, :min_properties

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

    def enum?
      !enum.empty?
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
