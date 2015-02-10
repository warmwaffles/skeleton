require 'skeleton/swagger/serializer'

module Skeleton
  module Swagger
    def self.serialize(structure)
      Skeleton::Swagger::Serializer.new(structure).to_h
    end
  end
end
