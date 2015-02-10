require 'skeleton/attributes'

module Skeleton
  # @abstract This is simply an abstract class
  class Schema
    extend Skeleton::Attributes

    PRIMITIVES = %w(string number integer boolean array file)

    attr_accessor :ref, :title, :description, :default, :maximum,
      :exclusive_maximum, :minimum, :exclusive_minimum, :max_length,
      :min_length, :pattern, :max_items, :min_items, :unique_items,
      :max_properties, :min_properties, :required, :multiple_of

    attr_reader :type, :format, :items

    attr_presence :ref, :title, :description, :default, :maximum,
      :exclusive_maximum, :minimum, :exclusive_minimum, :max_length,
      :min_length, :pattern, :max_items, :min_items, :unique_items,
      :max_properties, :min_properties, :required, :format, :multiple_of,
      :items

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.send(setter, v) if self.respond_to?(setter)
      end
    end

    def items=(value)
      case value
      when Hash
        @items = Skeleton::Items.new(value)
      else
        @items = value
      end
    end

    def properties
      @properties ||= {}
    end

    def properties?
      !properties.empty?
    end

    def enum
      @enum ||= []
    end

    def format=(value)
      @format = value.to_s
    end

    def type=(value)
      @type = value.to_s
    end

    def primitive?
      PRIMITIVES.include?(@type)
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
