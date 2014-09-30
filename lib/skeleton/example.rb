module Skeleton
  class Example
    def initialize
      @params = {}
    end

    def param(key, value)
      p = key.to_s.downcase
      @params[p] = value
    end

    def to_h
      @params
    end
    alias_method :to_hash, :to_h
  end
end
