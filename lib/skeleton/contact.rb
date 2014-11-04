module Skeleton
  class Contact
    attr_accessor :name, :email, :url

    def initialize(args={})
      @name  = args[:name]
      @email = args[:email]
      @url   = args[:url]
    end
  end
end
