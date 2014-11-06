require 'skeleton/attributes'

module Skeleton
  class Security
    extend Skeleton::Attributes

    attr_accessor :type, :description, :name, :location, :flow, :authorization_url,
                  :token_url, :scopes

    attr_presence :type, :description, :name, :location, :flow, :authorization_url,
                  :token_url, :scopes

    def initialize(args={})
      args.each do |k, v|
        setter = "#{k}="
        self.public_send(setter, v) if self.respond_to?(setter)
      end
    end
  end
end
