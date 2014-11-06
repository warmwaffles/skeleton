require 'skeleton/parameter'
require 'skeleton/response'
require 'skeleton/attributes'

module Skeleton
  class Operation
    extend Skeleton::Attributes

    attr_accessor :tags, :summary, :description, :external_docs, :operation_id,
                  :consumes, :produces, :parameters, :responses, :schemes,
                  :deprecated, :security
    attr_presence :summary, :description, :external_docs, :operation_id, :deprecated

    def initialize(args={})
      @tags          = Array(args[:tags])
      @summary       = args[:summary]
      @description   = args[:description]
      @external_docs = args[:external_docs]
      @operation_id  = args[:operation_id]
      @consumes      = Array(args[:consumes])
      @produces      = Array(args[:produces])
      @parameters    = Array(args[:parameters])
      @responses     = args[:responses] || Hash.new
      @schemes       = Array(args[:schemes])
      @deprecated    = args[:deprecated]
      @security      = Array(args[:security])
    end

    def response(name, args={})
      @responses[name] = Skeleton::Response.new(args)
    end

    def tags?
      !@tags.empty?
    end

    def consumes?
      !@consumes.empty?
    end

    def produces?
      !@produces.empty?
    end

    def parameters?
      !@parameters.empty?
    end

    def responses?
      !@responses.empty?
    end

    def schemes?
      !@schemes.empty?
    end

    def security?
      !@security.empty?
    end

    def tag(value)
      @tags << value
    end

    def parameter(location, name, &block)
      param = Parameter.new(location: location, name: name)
      yield(param) if block
      @parameters << param
    end
  end
end
