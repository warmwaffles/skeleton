require 'multi_json'
require 'skeleton/attributes'

module Skeleton
  class Model
    extend Skeleton::Attributes

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.public_send(setter, v) if self.respond_to?(setter)
      end
    end

    def to_swagger_hash
      raise(NotImplementedError)
    end

    def to_h
      raise(NotImplementedError)
    end

    def to_json
      MultiJson.dump(to_h)
    end

    def to_swagger_json
      MultiJson.dump(to_swagger_hash)
    end
  end
end
