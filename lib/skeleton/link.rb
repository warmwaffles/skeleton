module Skeleton
  class Link
    attr_accessor :rel, :href, :options, :description
    attr_accessor :templated

    def initialize(args={})
      raise(ArgumentError, ':rel is required') unless args[:rel]
      raise(ArgumentError, ':href is required') unless args[:href]

      @options = Hash.new
      args.each do |k, v|
        if self.respond_to?("#{k}=")
          self.send("#{k}=", v)
        else
          @options[k.to_s] = v
        end
      end
    end

    def method_missing(m, *args, &block)
      if @options.key?(m.to_s)
        @options[m.to_s]
      else
        super
      end
    end

    def templated?
      !!@templated
    end

    def <=>(other)
      @rel <=> other.rel
    end

    def eql?(other)
      return false unless other.respond_to?(:rel)
      @rel.eql?(other.rel)
    end

    def to_h
      hash = Hash.new
      hash['rel'] = @rel
      hash['href'] = @href
      @options.each do |k, v|
        hash[k.to_s] = v
      end
      hash
    end
    alias_method :to_hash, :to_h

    def to_s
      opts = options.map { |k,v| '%s="%s";' % [k, v] }.join(' ')
      '<%s>; rel="%s"; templated="%s" %s' % [href, rel, templated?, opts]
    end
  end
end
