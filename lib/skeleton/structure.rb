require 'skeleton/path'
require 'skeleton/info'
require 'skeleton/parameter'
require 'skeleton/attributes'

module Skeleton
  class Structure
    extend Skeleton::Attributes

    attr_accessor :paths, :consumes, :produces, :schemes, :host, :base_path,
                  :info, :definitions, :parameters, :security_definitions, :tags,
                  :external_docs
    attr_presence :info

    def initialize(args={})
      @paths       = args[:paths] || Hash.new
      @consumes    = Array(args[:consumes])
      @produces    = Array(args[:produces])
      @schemes     = Array(args[:schemes])
      @security    = Array(args[:security])
      @tags        = Array(args[:tags])
      @definitions = args[:definitions] || Hash.new
      @parameters  = args[:parameters] || Hash.new
      @host        = args[:host]
      @base_path   = args[:base_path]
      @info        = args[:info] || Skeleton::Info.new

      @external_docs = args[:external_docs]
      @security_definitions = args[:security_definitions] || Hash.new
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
        @paths[resource] = path_object
      else
        @paths[resource]
      end
    end

    def parameter(location, name, &block)
      param = Skeleton::Parameter.new({name: name})
      yield(param) if block
      @parameters[name] = param
    end
  end
end
