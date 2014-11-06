require 'skeleton/attributes'

module Skeleton
  class Schema
    extend Skeleton::Attributes

    attr_accessor :ref, :type, :format, :title, :description, :default,
                  :multiple_of, :maximum, :exclusive_maximum, :minimum,
                  :exclusive_minimum, :max_length, :min_length, :pattern,
                  :max_items, :min_items, :unique_items, :max_properties,
                  :min_properties, :required, :enum, :discriminator, :read_only,
                  :xml, :external_docs, :example

    attr_presence :required, :exclusive_maximum, :exclusive_minimum,
                  :unique_items, :discriminator, :read_only, :xml,
                  :external_docs, :example

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.public_send(setter, v) if self.respond_to?(setter)
      end
    end
  end
end
