module Skeleton
  class Example
    def initialize
      @params = {}
    end

    def param(key, value)
      p = key.to_s.downcase
      @params[p] = value
    end

    def to_hash
      @params
    end
    alias_method :to_h, :to_hash
  end
end
