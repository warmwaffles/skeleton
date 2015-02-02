require 'skeleton/attributes'
module Skeleton
  class Scope
    extend Skeleton::Attributes

    attr_accessor :name, :description
    attr_presence :name, :description

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.send(setter, v) if self.respond_to?(setter)
      end
    end

    alias_method :describe, :description=
  end
end
