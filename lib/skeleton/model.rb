require 'skeleton/schema'

module Skeleton
  class Model < Schema
    attr_reader :description, :descriptor

    def describe(value)
      @description = value
    end

    def extends(value)
      @descriptor = value
    end

    def required(name, options={})
      property(name, { required: true }.merge(options))
    end

    def optional(name, options={})
      property(name, { required: false }.merge(options))
    end

    def property(name, options={})
      properties[name] = Skeleton::Schema.new(options)
    end
  end
end
