require 'skeleton/schema'

module Skeleton
  class Model < Schema
    attr_reader :description, :descriptor, :name

    def describe(value)
      @description = value
    end

    def extends(value)
      @descriptor = value
    end

    def required(field, options={})
      property(field, { required: true }.merge(options))
    end

    def optional(field, options={})
      property(field, { required: false }.merge(options))
    end

    def property(field, options={})
      properties[field] = Skeleton::Schema.new(options)
    end
  end
end
