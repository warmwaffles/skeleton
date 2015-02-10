require 'test_helper'

require 'skeleton/path'

module Skeleton
  class PathTest < Minitest::Test
    def setup
      @path = Skeleton::Path.new
    end
    def test_get
      @path.get do
      end
      assert(@path.operations.key?(:get), 'expected the get operation to be present')
    end

    def test_put
      @path.put do
      end
      assert(@path.operations.key?(:put), 'expected the put operation to be present')
    end

    def test_post
      @path.post do
      end
      assert(@path.operations.key?(:post), 'expected the post operation to be present')
    end

    def test_patch
      @path.patch do
      end
      assert(@path.operations.key?(:patch), 'expected the patch operation to be present')
    end

    def test_delete
      @path.delete do
      end
      assert(@path.operations.key?(:delete), 'expected the delete operation to be present')
    end

    def test_options
      @path.options do
      end
      assert(@path.operations.key?(:options), 'expected the options operation to be present')
    end
  end
end
