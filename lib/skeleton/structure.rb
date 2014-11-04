require 'skeleton/path'
require 'skeleton/info'
require 'skeleton/parameter'

module Skeleton
  class Structure
    attr_accessor :paths, :consumes, :produces, :schemes, :host, :base_path,
                  :info, :definitions, :parameters, :security_definitions, :tags,
                  :external_docs

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

    def path(resource, &block)
      path_object = Skeleton::Path.new
      yield(path_object) if block
      @paths[resource] = path_object
    end

    def parameter(location, name, &block)
      param = Skeleton::Parameter.new({name: name})
      yield(param) if block
      @parameters[name] = param
    end

    def info?
      !!@info
    end
  end
end
