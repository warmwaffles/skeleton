require 'skeleton/attributes'

module Skeleton
  class Contact
    extend Skeleton::Attributes

    attr_accessor :name, :email, :url
    attr_presence :name, :email, :url

    def initialize(args={})
      @name  = args[:name]
      @email = args[:email]
      @url   = args[:url]
    end
  end
end
