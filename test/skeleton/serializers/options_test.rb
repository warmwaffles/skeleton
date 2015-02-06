require 'test_helper'

module Skeleton
  module Serializers
    class OptionsTest < Minitest::Test
      def structure
        @structure ||= Skeleton::Structure.new
      end

      def serializer
        @serializer ||= Skeleton::Serializers::Options.new(structure, path: '/accounts')
      end

      def test_deeply_nested_dependencies
        Factories::StructureFactory.configure_basic_structure(structure)
        hash = serializer.to_h

        refute_nil(hash[:definitions], 'Expected definitions to be present')
        refute_nil(hash[:definitions]['Accounts'])
        refute_nil(hash[:definitions]['AccountData'])
        refute_nil(hash[:definitions]['Meta'])
        refute_nil(hash[:definitions]['Error'])
        refute_nil(hash[:definitions]['Link'])
        refute_nil(hash[:definitions]['Contact'])
        refute_nil(hash[:definitions]['ErrorResponse'])
      end

      def test_empty_structure
        assert_raises(Skeleton::Error) { serializer.to_h }
      end

      def test_reference_non_existant_model
        structure.define_path('/accounts') do
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

        refute_nil(hash[:definitions], 'Expected definitions to be present')
        refute_nil(hash[:definitions]['Foo'], 'Expected Foo to be present')
        assert_empty(hash[:definitions]['Bar'], 'Expected Bar to be empty')
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
