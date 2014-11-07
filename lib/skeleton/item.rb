require 'skeleton/model'

module Skeleton
  class Item < Model
    attr_accessor :type, :format, :title, :description, :default, :multiple_of,
                  :maximum, :exclusive_maximum, :minimum, :exclusive_minimum,
                  :max_length, :min_length, :pattern, :max_items, :min_items,
                  :unique_items, :max_properties, :min_properties, :items

    attr_writer :enum
    attr_presence :exclusive_maximum, :exclusive_minimum, :unique_items, :items

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
      hash[:type]              = type              if type?
      hash[:format]            = format            if format?

      hash[:items] = items.to_hash if items?

      hash[:title]             = title             if title?
      hash[:description]       = description       if description?
      hash[:default]           = default           if default?
      hash[:multiple_of]       = multiple_of       if multiple_of?
      hash[:maximum]           = maximum           if maximum?
      hash[:exclusive_maximum] = exclusive_maximum if exclusive_maximum?
      hash[:minimum]           = minimum           if minimum?
      hash[:exclusive_minimum] = exclusive_minimum if exclusive_minimum?
      hash[:max_length]        = max_length        if max_length?
      hash[:min_length]        = min_length        if min_length?
      hash[:pattern]           = pattern           if pattern?
      hash[:max_items]         = max_items         if max_items?
      hash[:min_items]         = min_items         if min_items?
      hash[:unique_items]      = unique_items      if unique_items?
      hash[:max_properties]    = max_properties    if max_properties?
      hash[:min_properties]    = min_properties    if min_properties?
      hash[:enum]              = enum              if enum?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:type]             = type              if type?
      hash[:format]           = format            if format?

      hash[:items] = items.to_swagger_hash if items?

      hash[:title]            = title             if title?
      hash[:description]      = description       if description?
      hash[:default]          = default           if default?
      hash[:multipleOf]       = multiple_of       if multiple_of?
      hash[:maximum]          = maximum           if maximum?
      hash[:exclusiveMaximum] = exclusive_maximum if exclusive_maximum?
      hash[:minimum]          = minimum           if minimum?
      hash[:exclusiveMinimum] = exclusive_minimum if exclusive_minimum?
      hash[:maxLength]        = max_length        if max_length?
      hash[:minLength]        = min_length        if min_length?
      hash[:pattern]          = pattern           if pattern?
      hash[:maxItems]         = max_items         if max_items?
      hash[:minItems]         = min_items         if min_items?
      hash[:uniqueItems]      = unique_items      if unique_items?
      hash[:maxProperties]    = max_properties    if max_properties?
      hash[:minProperties]    = min_properties    if min_properties?
      hash[:enum]             = enum              if enum?
      hash
    end
  end
end
