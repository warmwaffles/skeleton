module Skeleton
  class Link
    attr_accessor :rel, :href, :options

    def initialize(args={})
      @options = args.dup
      @rel     = @options.delete(:rel)
      @href    = @options.delete(:href)
    end

    def to_h
      @options.merge({
        rel: @rel,
        href: @href
      })
    end
    alias_method :to_hash, :to_h
  end
end
