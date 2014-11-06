require 'skeleton/attributes'

module Skeleton
  class Header
    extend Skeleton::Attributes

    attr_accessor :type, :format, :title, :description, :default, :multiple_of,
                  :maximum, :exclusive_maximum, :minimum, :exclusive_minimum,
                  :max_length, :min_length, :pattern, :max_items, :min_items,
                  :unique_items, :max_properties, :min_properties

    attr_writer :enum
    attr_presence :exclusive_maximum, :exclusive_minimum, :unique_items

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
  end
end
