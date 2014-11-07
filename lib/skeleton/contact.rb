require 'skeleton/model'

module Skeleton
  class Contact < Model
    attr_accessor :name, :email, :url
    attr_presence :name, :email, :url

    def to_h
      hash = {}
      hash[:name] = name if name?
      hash[:email] = email if email?
      hash[:url] = url if url?
      hash
    end
    alias_method :to_swagger_hash, :to_h
  end
end
