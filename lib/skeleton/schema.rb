module Skeleton
  class Schema
    attr_accessor :ref, :type, :format, :title, :description, :default,
                  :multiple_of, :maximum, :exclusive_maximum, :minimum,
                  :exclusive_minimum, :max_length, :min_length, :pattern,
                  :max_items, :min_items, :unique_items, :max_properties,
                  :min_properties, :required, :enum, :discriminator, :read_only,
                  :xml, :external_docs, :example

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.public_send(setter, v) if self.respond_to?(setter)
      end
    end

    def required?
      !!@required
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

    def discriminator?
      !!@discriminator
    end

    def read_only?
      !!@read_only
    end

    def xml?
      !!@xml
    end

    def external_docs?
      !!@external_docs
    end

    def example?
      !!@example
    end
  end
end
