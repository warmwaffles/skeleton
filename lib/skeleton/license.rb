require 'skeleton/model'

module Skeleton
  class License < Model
    attr_accessor :name, :url
    attr_presence :name, :url

    def to_h
      hash = {}
      hash[:name] = name if name?
      hash[:url] = url if url?
      hash
    end
    alias_method :to_swagger_hash, :to_h
  end
end
