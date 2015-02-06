module Skeleton
  class Presenter
    def initialize(object)
      @object = object
    end

    def method_missing(m, *args, &blk)
      if @object.respond_to?(m)
        @object.__send__ m, *args, &blk
      else
        super
      end
    end

    def respond_to_missing?(m, include_private = false)
      @object.respond_to?(m, include_private)
    end
  end
end
