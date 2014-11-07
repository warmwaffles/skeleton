module Skeleton
  class Example
    def initialize
      @mimes = {}
    end

    def []=(mime_type, value)
      @mimes[mime_type] = value
    end

    def [](mime_type)
      @mimes[mime_type]
    end

    def to_h
      hash = {}
      @mimes.each do |type, value|
        hash[type] = value.respond_to?(:to_h) ? value.to_h : value
      end
      hash
    end

    def to_swagger_hash
      hash = {}
      @mimes.each do |type, value|
        hash[type] = value.respond_to?(:to_h) ? value.to_swagger_hash : value
      end
      hash
    end
  end
end
