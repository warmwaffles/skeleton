require 'test_helper'

require 'skeleton/builder'

module Skeleton
  class BuilderTest < Minitest::Test
    def setup
      @builder = Builder.new
    end

    def test_define_single
      @builder.define('get') do |action|
        action.description = 'something'
      end
      refute_nil(@builder.actions['get'])
      assert_equal('something', @builder.actions['get'].description)
    end

    def test_define_extra
      @builder.define('get', also: 'post') do |action|
        action.description = 'something'
      end
      refute_nil(@builder.actions['get'])
      refute_nil(@builder.actions['post'])
      assert_equal('something', @builder.actions['get'].description)
      assert_equal('something', @builder.actions['post'].description)
    end

    def test_define_array
      @builder.define('get', also: ['post']) do |action|
        action.description = 'something'
      end
      refute_nil(@builder.actions['get'])
      refute_nil(@builder.actions['post'])
      assert_equal('something', @builder.actions['get'].description)
      assert_equal('something', @builder.actions['post'].description)
    end

    def test_define_multiple
      @builder.define('get', also: ['post', 'head']) do |action|
        action.description = 'something'
      end
      refute_nil(@builder.actions['get'])
      refute_nil(@builder.actions['post'])
      refute_nil(@builder.actions['head'])
      assert_equal('something', @builder.actions['get'].description)
      assert_equal('something', @builder.actions['post'].description)
      assert_equal('something', @builder.actions['head'].description)
    end
  end
end
