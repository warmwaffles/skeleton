require 'skeleton/license'
require 'skeleton/contact'

module Skeleton
  class Info
    attr_accessor :title, :description, :terms_of_service, :license, :version

    def initialize(args={})
      @title            = args[:title]
      @description      = args[:description]
      @terms_of_service = args[:terms_of_service]
      @version          = args[:version]
    end

    def contact
      @contact ||= Skeleton::Contact.new
    end

    def license
      @license ||= Skeleton::License.new
    end

    def version?
      !!@version
    end

    def title?
      !!@title
    end

    def license?
      !!@license
    end

    def contact?
      !!@contact
    end

    def terms_of_service?
      !!@terms_of_service
    end

    def description?
      !!@description
    end
  end
end
