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
      @restrictions << desc
    end

    def to_hash
      hash = {
        type: type,
        description: description,
        required: required
      }
      hash[:default] = default if default
      hash[:allowed] = allowed if allowed
      hash[:restrictions] = restrictions unless restrictions.empty?
      hash
    end
  end
end
