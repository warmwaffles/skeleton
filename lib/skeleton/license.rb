require 'skeleton/attributes'

module Skeleton
  class License
    extend Skeleton::Attributes

    attr_accessor :name, :url
    attr_presence :name, :url

    def initialize(args={})
      @name = args[:name]
      @url  = args[:url]
    end
  end
end
