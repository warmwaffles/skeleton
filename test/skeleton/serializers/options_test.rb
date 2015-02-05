require 'test_helper'

module Skeleton
  module Serializers
    class OptionsTest < Minitest::Test
      def structure
        @structure ||= Skeleton::Structure.new
      end

      def serializer
        @serializer ||= Skeleton::Serializers::Options.new(structure, path: '/foos')
      end

      def test_empty_structure
        assert_raises(Skeleton::Error) { serializer.to_h }
      end

      def test_reference_non_existant_model
        structure.define_path('/foos') do
          get do
            response(200) do
              schema(ref: 'Foo')
            end
          end
        end
        structure.define_model('Foo') do
          property(:bar, type: 'array', items: { ref: 'Bar' })
        end

        hash = serializer.to_h

        refute_empty(hash[:definitions]['Foo'])
        assert_empty(hash[:definitions]['Bar'])
      end

      def test_path_that_does_not_exist
        structure.define_model('Foo') do
          property(:bar, type: 'array', items: { ref: 'Bar' })
        end

        assert_raises(Skeleton::Error) do
          serializer.to_h
        end
      end

      def test_path_not_specified
        assert_raises(Skeleton::Error) do
          Skeleton::Serializers::Options.new(structure)
        end
      end
    end
  end
end
