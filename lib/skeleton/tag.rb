require 'skeleton/attributes'
module Skeleton
  class Tag
    extend Skeleton::Attributes

    attr_accessor :name, :description, :external_docs
    attr_presence :name, :description, :external_docs

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.send(setter, v) if self.respond_to?(setter)
      end
    end

    alias_method :describe, :description=
    alias_method :document, :external_docs=
  end
end
