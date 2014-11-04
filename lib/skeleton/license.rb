module Skeleton
  class License
    attr_accessor :name, :url

    def initialize(args={})
      @name = args[:name]
      @url  = args[:url]
    end

    def name?
      !!@name
    end

    def url?
      !!@url
    end
  end
end
