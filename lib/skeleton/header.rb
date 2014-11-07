require 'skeleton/model'

module Skeleton
  class Header < Model
    attr_accessor :type, :format, :title, :description, :default, :multiple_of,
                  :maximum, :exclusive_maximum, :minimum, :exclusive_minimum,
                  :max_length, :min_length, :pattern, :max_items, :min_items,
                  :unique_items, :max_properties, :min_properties

    attr_writer :enum
    attr_presence :exclusive_maximum, :exclusive_minimum, :unique_items

    def enum
      @enum ||= []
    end

    def enum?
      !enum.empty?
    end

    def to_h
      hash = {}
      hash[:description]       = header.description       if header.description?
      hash[:type]              = header.type              if header.type?
      hash[:format]            = header.format            if header.format?
      hash[:items]             = header.items             if header.items?
      hash[:collection_format] = header.collection_format if header.collection_format?
      hash[:default]           = header.default           if header.default?
      hash[:maximum]           = header.maximum           if header.maximum?
      hash[:exclusive_maximum] = header.exclusive_maximum if header.exclusive_maximum?
      hash[:minimum]           = header.minimum           if header.minimum?
      hash[:exclusive_minimum] = header.exclusive_minimum if header.exclusive_minimum?
      hash[:max_length]        = header.max_length        if header.max_length?
      hash[:min_length]        = header.min_length        if header.min_length?
      hash[:pattern]           = header.pattern           if header.pattern?
      hash[:max_items]         = header.max_items         if header.max_items?
      hash[:min_items]         = header.min_items         if header.min_items?
      hash[:unique_items]      = header.unique_items      if header.unique_items?
      hash[:enum]              = header.enum              if header.enum?
      hash[:multiple_of]       = header.multiple_of       if header.multiple_of?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:description]      = header.description       if header.description?
      hash[:type]             = header.type              if header.type?
      hash[:format]           = header.format            if header.format?
      hash[:items]            = header.items             if header.items?
      hash[:collectionFormat] = header.collection_format if header.collection_format?
      hash[:default]          = header.default           if header.default?
      hash[:maximum]          = header.maximum           if header.maximum?
      hash[:exclusiveMaximum] = header.exclusive_maximum if header.exclusive_maximum?
      hash[:minimum]          = header.minimum           if header.minimum?
      hash[:exclusiveMinimum] = header.exclusive_minimum if header.exclusive_minimum?
      hash[:maxLength]        = header.max_length        if header.max_length?
      hash[:minLength]        = header.min_length        if header.min_length?
      hash[:pattern]          = header.pattern           if header.pattern?
      hash[:maxItems]         = header.max_items         if header.max_items?
      hash[:minItems]         = header.min_items         if header.min_items?
      hash[:uniqueItems]      = header.unique_items      if header.unique_items?
      hash[:enum]             = header.enum              if header.enum?
      hash[:multipleOf]       = header.multiple_of       if header.multiple_of?
      hash
    end
  end
end
