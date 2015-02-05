require 'test_helper'

module Skeleton
  module Serializers
    class SwaggerTest < Minitest::Test
      def structure
        @structure ||= Skeleton::Structure.new
      end

      def serializer
        @serializer ||= Skeleton::Serializers::Swagger.new(structure)
      end

      def test_empty_structure
        result = serializer.to_h
        assert_equal('2.0', result[:swagger])
        refute_nil(result[:info], 'expected the info hash to be present')

        assert(result.key?(:basePath))
        assert(result.key?(:host))
        assert_empty(result[:schemes])
        assert_empty(result[:consumes])
        assert_empty(result[:produces])
        assert_empty(result[:tags])
        assert_empty(result[:paths])
        assert_empty(result[:definitions])
      end
    end
  end
end
