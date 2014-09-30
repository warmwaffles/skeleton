require 'test_helper'

require 'skeleton/action'

module Skeleton
  class ActionTest < Minitest::Test
    def setup
      @action = Action.new
    end

    def test_param
      @action.param(:foo) do |param|
        param.type = 'integer'
        param.required = true
      end
      refute_nil(@action.parameters['foo'], 'expected parameters to contain "foo"')
      parameter = @action.parameters['foo']
      assert_equal('integer', parameter.type)
      assert(parameter.required, 'expected the parameter to be required')

      @action.param('bar[nested]') do |param|
        param.type = 'string'
        param.required = false
      end
      refute_nil(@action.parameters['bar[nested]'], 'expected parameters to contain "bar[nested]"')
      parameter = @action.parameters['bar[nested]']
      assert_equal('string', parameter.type)
      refute(parameter.required, 'expected the parameter to not be required')
    end

    def test_link
      assert_raises(ArgumentError) do
        @action.link({})
      end

      assert_raises(ArgumentError) do
        @action.link(name: 'Self', href: 'http://example.org/resource/{id}', templated: true)
      end

      assert_raises(ArgumentError) do
        @action.link(name: 'Self', rel: 'self', templated: true)
      end

      @action.link(name: 'Self', rel: 'self', href: 'http://example.org/resource/{id}', templated: true)
      refute_nil(@action.links['self'])
      @action.link(name: 'Root', rel: 'root', href: 'http://example.org/')
      refute_nil(@action.links['root'])
    end

    def test_example
      assert_empty(@action.examples)
      @action.example do |e|
        e.param('some[val]', '123')
      end
      assert_equal(1, @action.examples.count)
      @action.example do |e|
        e.param('some[val]', '123')
      end
      assert_equal(2, @action.examples.count)
    end

    def test_to_h
      @action.description = 'test'
      @action.param(:foo) do |param|
        param.type = 'integer'
        param.required = true
        param.allowed = [12]
      end

      hash = @action.to_h

      assert_equal('test', hash['description'])
      refute_nil(hash['links'])
      refute_nil(hash['examples'])
      refute_nil(hash['parameters'])
    end
  end
end
