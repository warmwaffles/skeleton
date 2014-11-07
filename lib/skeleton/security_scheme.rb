require 'skeleton/model'
require 'skeleton/scopes'

module Skeleton
  class SecurityScheme < Model
    attr_accessor :type, :description, :name, :location, :flow, :authorization_url,
                  :token_url, :scopes

    attr_presence :type, :description, :name, :location, :flow, :authorization_url,
                  :token_url, :scopes

    def scopes=(value)
      case value
      when Hash
        @scopes = Skeleton::Scopes.new(value)
      else
        @scopes = value
      end
    end

    def to_h
      hash = {}
      hash[:type]              = type              if type?
      hash[:description]       = description       if description?
      hash[:name]              = name              if name?
      hash[:location]          = location          if location?
      hash[:flow]              = flow              if flow?
      hash[:authorization_url] = authorization_url if authorization_url?
      hash[:token_url]         = token_url         if token_url?
      hash[:scopes]            = scopes.to_h       if scopes?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:type]              = type              if type?
      hash[:description]       = description       if description?
      hash[:name]              = name              if name?
      hash[:location]          = location          if location?
      hash[:flow]              = flow              if flow?
      hash[:authorizationUrl]  = authorization_url if authorization_url?
      hash[:tokenUrl]          = token_url         if token_url?
      hash[:scopes]            = scopes.to_swagger_hash if scopes?
      hash
    end
  end
end
