require 'test_helper'

require 'skeleton/parameter'

module Skeleton
  class ParameterTests < Minitest::Test
    def parameter
      @parameter ||= Skeleton::Parameter.new
    end

    def test_body?
      parameter.location = 'body'
      assert(parameter.body?)
    end

    def test_query?
      parameter.location = 'query'
      refute(parameter.body?)
      assert(parameter.query?)
    end

    def test_path?
      parameter.location = 'path'
      refute(parameter.body?)
      assert(parameter.path?)
    end

    def test_header?
      parameter.location = 'header'
      refute(parameter.body?)
      assert(parameter.header?)
    end
  end
end
