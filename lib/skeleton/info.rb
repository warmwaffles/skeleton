require 'skeleton/license'
require 'skeleton/contact'
require 'skeleton/attributes'

module Skeleton
  class Info
    extend Skeleton::Attributes

    attr_accessor :title, :description, :terms_of_service, :license, :version
    attr_presence :title, :description, :terms_of_service, :license, :version

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
  end
end
