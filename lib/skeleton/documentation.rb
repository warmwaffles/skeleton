module Skeleton
  class Documentation
    attr_accessor :description, :url

    def initialize(args={})
      @description = args[:description]
      @url         = args[:url]
    end

    def description?
      !!@description
    end

    def url?
      !!@url
    end
  end
end
