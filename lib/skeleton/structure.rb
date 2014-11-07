require 'skeleton/model'
require 'skeleton/path'
require 'skeleton/info'
require 'skeleton/parameter'
require 'skeleton/responses'
require 'skeleton/security_definitions'

module Skeleton
  class Structure < Model
    attr_accessor :host, :base_path, :external_docs
    attr_presence :info, :host, :base_path, :external_docs, :security
    attr_not_empty :consumes, :responses, :produces, :schemes, :security, :tags,
                   :definitions, :parameters, :paths, :security_definitions

    def responses=(value)
      case value
      when Hash
        Skeleton::Responses.new(value)
      else
        @responses = value
      end
    end

    def responses
      @responses ||= Skeleton::Responses.new
    end

    def consumes=(value)
      @consumes = Array(value)
    end

    def consumes
      @consumes ||= []
    end

    def produces=(value)
      @produces = Array(value)
    end

    def produces
      @produces ||= []
    end

    def schemes=(value)
      @schemes = Array(value)
    end

    def schemes
      @schemes ||= []
    end

    def security=(value)
      @security = Array(value)
    end

    def security
      @security ||= []
    end

    def tags=(value)
      @tags = Array(value)
    end

    def tags
      @tags ||= []
    end

    def info
      @info ||= Skeleton::Info.new
    end

    def definitions
      @definitions ||= {}
    end

    def parameters
      @parameters ||= {}
    end

    def paths
      @paths ||= {}
    end

    def security_definitions
      @security_definitions ||= Skeleton::SecurityDefinitions.new
    end

    # Define or get a path. If a block is provided, it will define a new path
    # object. If no block is provided, the current block will be returned
    #
    # @param resource [String] the api path
    #
    # @return [Skeleton::Path]
    def path(resource, &block)
      if block
        path_object = Skeleton::Path.new
        yield(path_object)
        paths[resource] = path_object
      else
        paths[resource]
      end
    end

    def parameter(location, name, &block)
      param = Skeleton::Parameter.new({name: name})
      yield(param) if block
      parameters[name] = param
    end

    def to_h
      hash = {}
      hash[:info] = info.to_h if info?
      hash[:host] = host if host?
      hash[:base_path] = base_path if base_path?
      hash[:external_docs] = external_docs if external_docs?
      hash[:schemes]  = schemes if schemes?
      hash[:consumes] = consumes if consumes?
      hash[:produces] = produces if produces?

      if paths?
        hash[:paths] = {}
        paths.each do |resource, path|
          hash[:paths][resource] = path.to_h
        end
      end

      if parameters?
        hash[:parameters] = {}
        parameters.each do |name, parameter|
          hash[:parameters][name] = parameter.to_h
        end
      end

      hash[:responses] = responses.to_h if responses?

      if security_definitions?
        hash[:security_definitions] = security_definitions.to_h
      end

      if security?
        hash[:security] = security.map(&:to_h)
      end

      hash[:tags] = tags.map(&:to_h) if tags?
      hash
    end

    def to_swagger_hash
      hash = {}
      hash[:info] = info.to_swagger_hash if info?
      hash[:host] = host if host?
      hash[:basePath] = base_path if base_path?
      hash[:externalDocs] = external_docs if external_docs?
      hash[:schemes]  = schemes if schemes?
      hash[:consumes] = consumes if consumes?
      hash[:produces] = produces if produces?

      if paths?
        hash[:paths] = {}
        paths.each do |resource, path|
          hash[:paths][resource] = path.to_swagger_hash
        end
      end

      if parameters?
        hash[:parameters] = {}
        parameters.each do |name, parameter|
          hash[:parameters][name] = parameter.to_swagger_hash
        end
      end

      if responses?
        hash[:responses] = responses.to_swagger_hash
      end

      if security_definitions?
        hash[:securityDefinitions] = security_definitions.to_swagger_hash
      end

      if security?
        hash[:security] = security.map(&:to_swagger_hash)
      end

      if tags?
        hash[:tags] = tags.map(&:to_swagger_hash)
      end

      hash
    end
  end
end
