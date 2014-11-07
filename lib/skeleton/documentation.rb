require 'skeleton/model'

module Skeleton
  class Documentation < Model

    attr_accessor :description, :url
    attr_presence :description, :url

    def to_h
      hash = {}
      hash[:description] = description if description?
      hash[:url] = url if url?
      hash
    end
    alias_method :to_swagger_hash, :to_h
  end
end
