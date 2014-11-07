require 'skeleton/model'

module Skeleton
  class Tag < Model
    attr_accessor :name, :description, :external_docs
    attr_presence :name, :description, :external_docs

    def to_h
      hash = {}
      hash[:name]          = name if name?
      hash[:description]   = description if description?
      hash[:external_docs] = external_docs if external_docs?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:name]         = name if name?
      hash[:description]  = description if description?
      hash[:externalDocs] = external_docs if external_docs?
      hash
    end
  end
end
