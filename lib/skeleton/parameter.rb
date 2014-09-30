module Skeleton
  class Parameter
    attr_accessor :type, :description, :required, :allowed, :default, :restrictions

    def initialize(args={})
      @required = false
      @allowed = []
      @restrictions = []

      args.each do |k, v|
        self.send("#{k}=", v) if self.respond_to?("#{k}=")
      end
    end

    def restriction(desc)
      @restrictions.push(desc)
    end

    def to_h
      hash = {
        'type' => type,
        'description' => description,
        'required' => required
      }
      hash['default'] = default if default
      hash['allowed'] = allowed if allowed
      hash['restrictions'] = restrictions unless restrictions.empty?
      hash
    end
    alias_method :to_hash, :to_h
  end
end
