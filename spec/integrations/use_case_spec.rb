require 'spec_helper'

require 'skeleton'
require 'skeleton/serializers/swagger'
require 'pp'

describe 'A simple use case' do
  describe 'validating the first case' do
    it 'works' do
      @structure = Skeleton.build do |s|
        s.host = 'api.example.com'
        s.info.version = '1.0'
        s.info.title = 'Waffles Emporium API'
        s.info.description = 'A test integration'

        s.info.contact.name = 'WarmWaffles'
        s.info.contact.email = 'warmwaffles@gmail.com'
        s.info.contact.url = 'https://github.com/warmwaffles/skeleton'

        s.info.license.name = 'MIT'

        s.schemes = %w(https)
        s.consumes = %(application/json)
        s.produces = %(application/json)

        s.path('/users') do |path|
          path.get do |o|
            o.tag('users')
            o.parameter(:query, 'limit') do |p|
              p.description = 'maximum number of results to return'
              p.type = 'integer'
              p.format = 'int32'
              p.required = false
            end
            o.parameter(:query, 'offset') do |p|
              p.description = 'offset within the results returned'
              p.type = 'integer'
              p.format = 'int32'
              p.required = false
            end
          end

          path.post do |o|
            o.tag('user')
            o.parameter(:body, 'user[email]') do |p|
              p.description = 'the user email'
              p.type = 'string'
              p.required = true
            end
            o.parameter(:body, 'user[name]') do |p|
              p.description = 'the user name'
              p.type = 'string'
              p.required = true
            end
            o.parameter(:body, 'user[password]') do |p|
              p.description = 'the user password'
              p.type = 'string'
              p.required = true
            end
            o.parameter(:body, 'user[password_confirmation]') do |p|
              p.description = 'the user password confirmation'
              p.type = 'string'
              p.required = true
            end
          end
        end

        s.path('/users/{user_id}') do |path|
          path.get do |o|
            o.tag('user')
            o.parameter(:query, 'user_id') do |p|
              p.description = 'the user id'
              p.type = 'string'
              p.format = 'uuid'
              p.required = true
            end
          end

          path.put do |o|
            o.tag('user')
            o.parameter(:body, 'user[email]') do |p|
              p.description = 'the user email'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[name]') do |p|
              p.description = 'the user name'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[password]') do |p|
              p.description = 'the user password'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[password_confirmation]') do |p|
              p.description = 'the user password confirmation'
              p.type = 'string'
              p.required = false
            end
          end

          path.patch do |o|
            o.tag('user')
            o.parameter(:body, 'user[email]') do |p|
              p.description = 'the user email'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[name]') do |p|
              p.description = 'the user name'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[password]') do |p|
              p.description = 'the user password'
              p.type = 'string'
              p.required = false
            end
            o.parameter(:body, 'user[password_confirmation]') do |p|
              p.description = 'the user password confirmation'
              p.type = 'string'
              p.required = false
            end
          end
        end
      end
    end
  end
end
