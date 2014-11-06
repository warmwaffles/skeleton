require 'skeleton/attributes'

module Skeleton
  class Parameter
    extend Skeleton::Attributes

    attr_accessor :name, :location, :description, :required, :schema, :type,
                  :format, :items, :collection_format, :default, :maximum,
                  :exclusive_maximum, :minimum, :exclusive_minimum, :max_length,
                  :min_length, :unique_items, :multiple_of, :min_items,
                  :max_items, :pattern

    attr_writer :enum
    attr_presence :pattern, :multiple_of, :unique_items, :max_items, :min_items,
                  :min_length, :max_length, :minimum, :maximum, :default,
                  :collection_format, :items, :format, :type, :schema, :required,
                  :description, :location, :name, :exclusive_maximum,
                  :exclusive_minimum, :unique_items

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
