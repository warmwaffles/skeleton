require 'skeleton/parameter'
require 'skeleton/response'

module Skeleton
  class Operation
    attr_accessor :tags, :summary, :description, :external_docs, :operation_id,
                  :consumes, :produces, :parameters, :responses, :schemes,
                  :deprecated, :security

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

    def summary?
      !!@summary
    end

    def description?
      !!@description
    end

    def external_docs?
      !!@externa_docs
    end

    def operation_id?
      !!@operation_id
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

    def deprecated?
      !!@deprecated
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

    def deprecated?
      !!@deprecated
    end
  end
end
