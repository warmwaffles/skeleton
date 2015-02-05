require 'set'

require 'skeleton/path'
require 'skeleton/model'
require 'skeleton/contact'
require 'skeleton/license'
require 'skeleton/tag'
require 'skeleton/scope'
require 'skeleton/parameter'
require 'skeleton/response'
require 'skeleton/security_scheme'

module Skeleton
  class Structure
    attr_accessor :terms, :host, :base_path, :title, :version, :description,
      :external_docs

    alias_method :describe, :description=

    def configure(&block)
      return self unless block

      if block.arity == 0
        self.instance_eval(&block)
      else
        yield(self)
      end

      self
    end

    def schemes
      @schemes ||= Set.new
    end

    def consumes
      @consumes ||= Set.new
    end

    def produces
      @produces ||= Set.new
    end

    def license
      @license ||= Skeleton::License.new
    end

    def tags
      @tags ||= {}
    end

    def contact
      @contact ||= Skeleton::Contact.new
    end

    def responses
      @responses ||= {}
    end

    def parameters
      @parameters ||= {}
    end

    def scopes
      @scopes ||= {}
    end

    def security
      @security ||= {}
    end

    def paths
      @paths ||= {}
    end

    def models
      @models ||= {}
    end

    def scheme(*types)
      types.each { |t| schemes.add(t.to_s) }
    end

    def consume(*types)
      types.each { |t| consumes.add(t.to_s) }
    end

    def produce(*types)
      types.each { |t| produces.add(t.to_s) }
    end

    def parameters?
      !parameters.empty?
    end

    def responses?
      !responses.empty?
    end

    def secure?
      !security.empty?
    end

    def define_response(name, &block)
      responses[name] = Skeleton::Response.new
      responses[name].instance_eval(&block) if block
      responses[name]
    end

    def define_parameter(name, &block)
      parameters[name] = Skeleton::Parameter.new
      parameters[name].instance_eval(&block) if block
      parameters[name]
    end

    def define_scope(name, &block)
      scopes[name] = Skeleton::Scope.new
      scopes[name].instance_eval(&block) if block
      scopes[name]
    end

    def define_security(name, &block)
      security[name] = Skeleton::SecurityScheme.new(name: name)
      security[name].instance_eval(&block) if block
      security[name]
    end

    def define_tag(name, &block)
      tags[name] = Skeleton::Tag.new(name: name)
      tags[name].instance_eval(&block) if block
      tags[name]
    end

    def define_path(path, options={}, &block)
      paths[path] = Skeleton::Path.new
      paths[path].instance_eval(&block) if block
      paths[path]
    end

    def define_model(name, options={}, &block)
      models[name] = Skeleton::Model.new
      models[name].instance_eval(&block) if block
      models[name]
    end
  end
end
