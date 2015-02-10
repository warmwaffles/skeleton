require 'skeleton/response'
require 'skeleton/parameters'

module Skeleton
  class Operation
    attr_accessor :description, :summary, :id
    attr_reader :responses

    def initialize
      @responses = {}
      @tags = {}
      @consumes = {}
      @produces = {}
      @parameters = Skeleton::Parameters.new
    end

    alias_method :summarize, :summary=
    alias_method :describe, :description=
    alias_method :identify, :id=

    def deprecate
      @deprecated = true
    end

    def deprecated?
      !!@deprecated
    end

    def id?
      !!@id
    end

    def tag(*values)
      values.each { |v| @tags[v] = true }
    end

    def tags
      @tags.map { |t,_| t.to_s }
    end

    def consume(*values)
      values.each { |t| @consumes[t.to_s] = true }
    end

    def consumes
      @consumes.map { |s, _| s }
    end

    def consumes?
      !@consumes.empty?
    end

    def produce(*values)
      values.each { |t| @produces[t.to_s] = true }
    end

    def produces
      @produces.map { |s, _| s }
    end

    def produces?
      !@produces.empty?
    end

    def response(value, options={}, &block)
      @responses[value] = Skeleton::Response.new
      @responses[value].instance_eval(&block) if block
      @responses[:default] = @responses[value] if options[:default]
      @responses[value]
    end

    def parameters(location=:query, &block)
      params = Skeleton::Parameters.new
      params.instance_eval(&block) if block
      params.each do |p|
        p.location = location
        @parameters.add(p)
      end
      @parameters
    end

    def parameters?
      !@parameters.empty?
    end
  end
end
