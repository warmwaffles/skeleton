require 'skeleton/structure'
require 'skeleton/serializers/swagger'

module Skeleton
  class Config
    def structure
      @structure ||= Skeleton::Structure.new
    end

    def info(&block)
      yield(structure.info) if block
    end

    def define(&block)
      yield(structure) if block
    end

    def contact(&block)
      yield(structure.info.contact) if block
    end

    def license(&block)
      yield(structure.info.license) if block
    end

    def path(resource, &block)
      structure.path(resource, &block)
    end

    def to_swagger_json
      Skeleton::Serializers::Swagger.new(structure: structure).to_json
    end
  end
end
