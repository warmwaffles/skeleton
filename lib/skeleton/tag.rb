require 'skeleton/attributes'

module Skeleton
  class Tag
    extend Skeleton::Attributes

    attr_accessor :name, :description, :external_docs
    attr_presence :name, :description, :external_docs

    def initialize(args={})
      @name          = args[:name]
      @description   = args[:description]
      @external_docs = args[:external_docs]
    end
  end
end
