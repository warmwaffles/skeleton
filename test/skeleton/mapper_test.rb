require 'test_helper'

require 'skeleton'

module Skeleton
  class MapperTest < Minitest::Test

    def structure
      @structure ||= Skeleton::Structure.new
    end

    def setup
      structure.configure do
        define_model('Link') do
          describe('The link object used for api discovery')
          required(:href,      type: 'string')
          required(:rel,       type: 'string')
          optional(:templated, type: 'boolean')
          optional(:name,      type: 'string')
        end

        define_model('Error') do
          describe('Represents an error')
          required(:message, type: 'string')
          optional(:field,   type: 'string')
          optional(:errors,  type: 'array', items: { ref: 'Error' })
        end

        define_model('Meta') do
          describe('The meta information regarding the request')
          required(:status,  type: 'integer')
          optional(:message, type: 'string')
          optional(:errors,  type: 'array', items: { ref: 'Error' })
        end

        define_model('ErrorResponse') do
          describe('The information when there is an issue with a request')
          required(:meta, ref: 'Meta')
          required(:links, type: 'array', items: { ref: 'Link' })
        end

        define_model('Contact') do
          optional(:name, type: 'string')
          optional(:country, type: 'string')
          optional(:phone, type: 'string')
        end

        define_model('AccountData') do
          required(:id,         type: 'string', format: 'uuid')
          required(:name,       type: 'string')
          required(:status,     type: 'string', enum: %w(active canceled))
          required(:created_at, type: 'string', format: 'date-time')
          required(:updated_at, type: 'string', format: 'date-time')
          required(:contact,    ref: 'Contact')
          optional(:links,      type: 'array', items: { ref: 'Link' })
        end

        define_model('Account') do
          required(:meta,  ref: 'Meta')
          required(:data,  ref: 'AccountData')
          required(:links, type: 'array', items: { ref: 'Link' })
        end

        define_model('Accounts') do
          required(:meta,  ref: 'Meta')
          required(:data,  type: 'array', items: { ref: 'AccountData' })
          required(:links, type: 'array', items: { ref: 'Link' })
        end

        define_path('/accounts') do
          get do
            response(200) do
              describe 'get a list of accounts'
              schema(ref: 'Accounts')
            end
          end
        end
      end
    end # end setup

    def test_the_mapping
    end
  end
end
