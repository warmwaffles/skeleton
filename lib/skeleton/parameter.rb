require 'skeleton/model'

module Skeleton
  class Parameter < Model
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

    def to_h
      hash = {}
      hash[:name]              = name              if name?
      hash[:location]          = location          if location?
      hash[:description]       = description       if description?
      hash[:required]          = required          if required?

      hash[:schema] = schema.to_h if schema?

      hash[:type]              = type              if type?
      hash[:format]            = format            if format?

      hash[:items] = items.to_h if items?

      hash[:collection_format] = collection_format if collection_format?
      hash[:default]           = default           if default?
      hash[:maximum]           = maximum           if maximum?
      hash[:exclusive_maximum] = exclusive_maximum if exclusive_maximum?
      hash[:minimum]           = minimum           if minimum?
      hash[:exclusive_minimum] = exclusive_minimum if exclusive_minimum?
      hash[:max_length]        = max_length        if max_length?
      hash[:min_length]        = min_length        if min_length?
      hash[:unique_items]      = unique_items      if unique_items?
      hash[:multiple_of]       = multiple_of       if multiple_of?
      hash[:min_items]         = min_items         if min_items?
      hash[:max_items]         = max_items         if max_items?
      hash[:pattern]           = pattern           if pattern?
      hash[:enum]              = enum              if enum?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:name]             = name              if name?
      hash[:location]         = location          if location?
      hash[:description]      = description       if description?
      hash[:required]         = required          if required?

      hash[:schema] = schema.to_swagger_json if schema?

      hash[:type]             = type              if type?
      hash[:format]           = format            if format?

      hash[:items] = items.to_swagger_json if items?

      hash[:collectionFormat] = collection_format if collection_format?
      hash[:default]          = default           if default?
      hash[:maximum]          = maximum           if maximum?
      hash[:exclusiveMaximum] = exclusive_maximum if exclusive_maximum?
      hash[:minimum]          = minimum           if minimum?
      hash[:exclusiveMinimum] = exclusive_minimum if exclusive_minimum?
      hash[:maxLength]        = max_length        if max_length?
      hash[:minLength]        = min_length        if min_length?
      hash[:uniqueItems]      = unique_items      if unique_items?
      hash[:multipleOf]       = multiple_of       if multiple_of?
      hash[:minItems]         = min_items         if min_items?
      hash[:maxItems]         = max_items         if max_items?
      hash[:pattern]          = pattern           if pattern?
      hash[:enum]             = enum              if enum?
      hash
    end
  end
end
