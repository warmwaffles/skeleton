require 'skeleton/attributes'

module Skeleton
  class Documentation
    extend Skeleton::Attributes

    attr_accessor :description, :url
    attr_presence :description, :url

    def initialize(args={})
      @description = args[:description]
      @url         = args[:url]
    end
  end
end
