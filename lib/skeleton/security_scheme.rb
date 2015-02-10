require 'skeleton/attributes'
require 'skeleton/scope'

module Skeleton
  class SecurityScheme
    extend Skeleton::Attributes

    attr_accessor :type, :description, :name, :location, :flow,
      :authorization_url, :token_url

    attr_presence :type, :description, :name, :location, :flow,
      :authorization_url, :token_url

    def initialize(args={})
      @scopes = {}

      args.each do |k, v|
        setter = "#{k}="
        self.send(setter, v) if self.respond_to?(setter)
      end
    end

    def define_scope(name, &block)
      @scopes[name] = Skeleton::Scope.new
      @scopes[name].instance_eval(&block)
      @scopes[name]
    end
  end
end
