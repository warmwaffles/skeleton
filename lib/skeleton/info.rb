require 'skeleton/model'
require 'skeleton/license'
require 'skeleton/contact'

module Skeleton
  class Info < Model
    attr_accessor :title, :description, :terms_of_service, :license, :version
    attr_presence :title, :description, :terms_of_service, :license, :version

    def contact
      @contact ||= Skeleton::Contact.new
    end

    def license
      @license ||= Skeleton::License.new
    end

    def to_h
      hash = {}
      hash[:title]            = title            if title?
      hash[:description]      = description      if description?
      hash[:version]          = version          if version?
      hash[:terms_of_service] = terms_of_service if terms_of_service?
      hash[:license]          = license.to_h
      hash[:contact]          = contact.to_h
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:title]          = title            if title?
      hash[:description]    = description      if description?
      hash[:version]        = version          if version?
      hash[:termsOfService] = terms_of_service if terms_of_service?
      hash[:license]        = license.to_swagger_hash
      hash[:contact]        = contact.to_swagger_hash
      hash
    end
  end
end
