require 'skeleton/model'
require 'skeleton/parameter'
require 'skeleton/responses'

module Skeleton
  class Operation < Model
    attr_accessor :summary, :description, :external_docs, :operation_id, :deprecated
    attr_presence :summary, :description, :external_docs, :operation_id, :deprecated
    attr_not_empty :tags, :consumes, :produces, :responses, :schemes, :security, :parameters

    attr_writer :responses

    def consumes
      @consumes ||= []
    end

    def consumes=(value)
      @consumes = Array(value)
    end

    def produces
      @produces ||= []
    end

    def produces=(value)
      @produces = Array(value)
    end

    def parameters
      @parameters ||= []
    end

    def parameters=(value)
      @parameters = Array(value)
    end

    def schemes
      @schemes ||= []
    end

    def schemes=(value)
      @schemes = Array(value)
    end

    def security
      @security ||= []
    end

    def security=(value)
      @security = Array(value)
    end

    def responses
      @responses ||= Skeleton::Responses.new
    end

    def tags=(value)
      @tags = Array(value)
    end

    def tags
      @tags ||= []
    end

    def response(name, args={})
      responses.set(name, args)
    end

    def tag(value)
      tags << value
    end

    def parameter(location, name, &block)
      param = Parameter.new(location: location, name: name)
      yield(param) if block
      parameters << param
    end

    def to_h
      hash = {}
      hash[:tags]          = self.tags          if self.tags?
      hash[:summary]       = self.summary       if self.summary?
      hash[:description]   = self.description   if self.description?
      hash[:external_docs] = self.external_docs if self.external_docs?
      hash[:operation_id]  = self.operation_id  if self.operation_id?
      hash[:consumes]      = self.consumes      if self.consumes?
      hash[:produces]      = self.produces      if self.produces?

      if self.parameters?
        hash[:parameters] = []
        self.parameters.each do |parameter|
          if parameter.respond_to?(:to_h)
            hash[:parameters] << parameter.to_h
          else
            hash[:parameters] = parameter
          end
        end
      end

      hash[:responses]  = self.responses.to_h if self.responses?
      hash[:schemes]    = self.schemes        if self.schemes?
      hash[:deprecated] = self.deprecated     if self.deprecated?
      if self.security?
        hash[:security] = []
        self.security.each do |sec|
          if sec.respond_to?(:to_h)
            hash[:secuirty] << sec.to_h
          else
            hash[:security] << sec
          end
        end
      end
      hash[:security] = self.deprecated if self.deprecated?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:tags]         = self.tags          if self.tags?
      hash[:summary]      = self.summary       if self.summary?
      hash[:description]  = self.description   if self.description?
      hash[:externalDocs] = self.external_docs if self.external_docs?
      hash[:operationId]  = self.operation_id  if self.operation_id?
      hash[:consumes]     = self.consumes      if self.consumes?
      hash[:produces]     = self.produces      if self.produces?

      if self.parameters?
        hash[:parameters] = []
        self.parameters.each do |parameter|
          if parameter.respond_to?(:to_swagger_hash)
            hash[:parameters] << parameter.to_swagger_hash
          else
            hash[:parameters] = parameter
          end
        end
      end

      hash[:responses]  = self.responses.to_swagger_hash if self.responses?

      hash[:schemes]    = self.schemes    if self.schemes?
      hash[:deprecated] = self.deprecated if self.deprecated?

      if self.security?
        hash[:security] = []
        self.security.each do |sec|
          if sec.respond_to?(:to_swagger_hash)
            hash[:secuirty] << sec.to_swagger_hash
          else
            hash[:security] << sec
          end
        end
      end
      hash[:security] = self.deprecated if self.deprecated?
      hash
    end
  end
end
