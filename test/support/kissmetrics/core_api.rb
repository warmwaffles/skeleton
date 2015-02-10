require 'skeleton'

module KISSmetrics
  module CoreAPI
    def self.structure
      skeleton = Skeleton.build do |s|
        s.title = 'KISSmetrics API'
        s.version = '1.0.0'
        s.description = 'A simply complex skeleton'

        s.terms = 'https://www.kissmetrics.com/terms'

        s.contact.name = 'KISSmetrics'
        s.contact.email = 'support@kissmetrics.com'
        s.contact.url = 'https://support.kissmetrics.com'

        s.license.name = 'KISSmetrics'
        s.license.url = 'https://www.kissmetrics.com'

        s.host = 'api.kissmetrics.com'
        s.base_path = '/core'
        s.scheme(:https)
        s.consume('application/json')
        s.produce('application/json')
      end

      skeleton.define_tag('products') do
        describe('The product')
      end

      skeleton.define_model('Link') do
        describe('The link object used for api discovery')
        required(:href,      type: 'string')
        required(:rel,       type: 'string')
        optional(:templated, type: 'boolean')
        optional(:name,      type: 'string')
      end

      skeleton.define_model('Error') do
        describe('Represents an error')
        required(:message, type: 'string')
        optional(:field,   type: 'string')
        optional(:errors,  type: 'array', items: { ref: 'Error' })
      end

      skeleton.define_model('Meta') do
        describe('The meta information regarding the request')
        required(:status,  type: 'integer')
        optional(:message, type: 'string')
        optional(:errors,  type: 'array', items: { ref: 'Error' })
      end

      skeleton.define_model('ErrorResponse') do
        describe('The information when there is an issue with a request')
        required(:meta, ref: 'Meta')
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      skeleton.define_model('WizardProperty') do
        required(:name,  type: 'string')
        required(:value, type: 'string')
      end

      skeleton.define_model('WizardRules') do
        required(:meta,  ref: 'Meta')
        required(:data,  type: 'array', items: { ref: 'WizardRuleData' })
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      skeleton.define_model('WizardRuleData') do
        required(:type,         type: 'string')
        required(:name,         type: 'string')
        optional(:display_name, type: 'string')
        required(:visible,      type: 'boolean')
      end

      skeleton.define_model('WizardRule') do
        required(:meta,  ref: 'Meta')
        required(:data,  type: 'array', items: { ref: 'WizardRuleData' })
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      skeleton.define_model('WizardUrlRule') do
        describe('The wizard url rule')
        extends('WizardRuleData')
        required(:url,          type: 'string')
        optional(:properties,   type: 'array', items: { ref: 'WizardProperty' })
      end

      skeleton.define_model('WizardClickRule') do
        describe('The wizard click rule')
        extends('WizardRuleData')
        required(:data,         type: 'string')
        optional(:properties,   type: 'array', items: { ref: 'WizardProperty' })
      end

      skeleton.define_model('WizardSubmitRule') do
        describe('The wizard submit rule')
        extends('WizardRuleData')
        required(:data,         type: 'string')
        optional(:properties,   type: 'array', items: { ref: 'WizardProperty' })
      end

      skeleton.define_model('WizardRegexRule') do
        describe('The wizard regex rule')
        extends('WizardRuleData')
        required(:data,         type: 'string')
        optional(:properties,   type: 'array', items: { ref: 'WizardProperty' })
      end

      skeleton.define_model('OptionsResponse') do
        describe('The subset of swagger options')
      end

      skeleton.define_model('NewProduct') do
        describe('The model required to build a product')
        required(:name,       type: 'string')
        required(:account_id, type: 'string', format: 'uuid')
      end

      skeleton.define_model('ProductData') do
        describe('The persisted product data')
        required(:id,    type: 'string', format: 'uuid')
        required(:name,  type: 'string')
      end

      skeleton.define_model('Product') do
        describe('The product')
        required(:meta,  ref: 'Meta')
        required(:data,  ref: 'ProductData')
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      skeleton.define_model('UserData') do
        describe('The persisted user data')
        required(:id,    type: 'string', format: 'uuid')
        required(:login, type: 'string', format: 'email')
      end

      skeleton.define_model('User') do
        describe('The user')
        required(:meta,  ref: 'Meta')
        required(:data,  ref: 'UserData')
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      skeleton.define_model('AccountData') do
        describe('The persisted account data')
        required(:id,   type: 'string', format: 'uuid')
        required(:name, type: 'string')
      end

      skeleton.define_model('Account') do
        describe('The account')
        required(:meta,  ref: 'Meta')
        required(:data,  ref: 'AccountData')
        required(:links, type: 'array', items: { ref: 'Link' })
      end

      # ##############################################################################
      # ##############################################################################
      skeleton.define_path('/products') do
        get do
          identify('list-products')
          tag('product')
          summarize('List products')
          describe('List all of the products')

          parameters(:query) do
            optional(:limit,  type: 'integer', format: 'int32', default: 20, maximum: 50, minimum: 0)
            optional(:offset, type: 'integer', format: 'int32', default: 0)
          end

          response(200, default: true) do
            describe('Product list')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'Product')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        head do
          tag('product')
          summarize('List products headers')
          describe('List the headers for the products action')

          parameters(:query) do
            optional(:limit,  type: 'integer', format: 'int32', default: 20, maximum: 50, minimum: 0)
            optional(:offset, type: 'integer', format: 'int32', default: 0)
          end

          response(200, default: true) do
            describe('Product list')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end
        end

        post do
          tag('product')
          summarize('Create product')
          describe('Create a product')

          parameters(:body) do
            required(:body, schema: { ref: 'NewProduct' })
          end

          response(201) do
            describe('Product created')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'Product')
          end

          response(400) do
            describe('Client error')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        options do
          tag('product')
          summarize('List actions for a product')
          describe('List actions for a product')

          parameters(:query) do
            optional(:limit,  type: 'integer', format: 'int32', default: 20, maximum: 50, minimum: 0)
            optional(:offset, type: 'integer', format: 'int32', default: 0)
          end

          response(200, default: true) do
            describe('Product action list')
            header('Allow', type: 'array', items: { type: 'string' }, collection_format: 'csv')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'OptionsResponse')
          end

          response(400) do
            describe('Client error')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end
      end

      # ##############################################################################
      # ##############################################################################
      skeleton.define_path('/products/{product_id}') do
        get do
          tag('product')
          summarize('Get product')
          describe('Get product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200) do
            describe('Product found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'Product')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Not Found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        head do
          tag('product')
          summarize('Get product')
          describe('Get product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200) do
            describe('Product found')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(404) do
            describe('Not Found')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end
        end

        options do
          tag('product')
          summarize('Get resource actions')
          describe('Get resource action')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200, default: true) do
            describe('Product actions')
            header('Allow', type: 'array', items: { type: 'string' }, collection_format: 'csv')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'OptionsResponse')
          end

          response(400) do
            describe('Client error')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end
      end

      # ##############################################################################
      # ##############################################################################
      skeleton.define_path('/products/{product_id}/wizard/rules') do
        get do
          tag('product')
          tag('event-library')
          summarize('List rules for a given product')
          describe('List rules for a given product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200) do
            describe('Product found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'WizardRules')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        head do
          tag('product')
          tag('event-library')
          summarize('List rules for a given product')
          describe('List rules for a given product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200, default: true) do
            describe('Product found')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end
        end

        options do
          tag('product')
          tag('event-library')
          summarize('List actions for the given product')
          describe('List actions for the given product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200, default: true) do
            describe('Product actions')
            header('Allow', type: 'array', items: { type: 'string' }, collection_format: 'csv')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'OptionsResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        post do
          tag('product')
          tag('event-library')
          summarize('Create rule for the product')
          describe('Create rule for the product')
          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(201) do
            describe('Rule created')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'WizardRule')
          end

          response(400) do
            describe('Client error')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        put do
          tag('product')
          tag('event-library')
          summarize('Update rule for the product')
          describe('Update rule for the product')
          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(200) do
            describe('Rule updated')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'WizardRule')
          end

          response(400) do
            describe('Client error')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end

        delete do
          identify('delete-wizard-rule')
          tag('product')
          tag('event-library')
          summarize('Delete rule for the product')
          describe('Delete rule for the product')

          parameters(:path) do
            required(:product_id, type: 'string', format: 'uuid', description: 'The product id')
          end

          response(204) do
            describe('Rule deleted')
            header('Link', type: 'string', description: 'The list of links for the resource')
          end

          response(403) do
            describe('Unauthorized')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end

          response(404) do
            describe('Product not found')
            header('Link', type: 'string', description: 'The list of links for the resource')
            schema(ref: 'ErrorResponse')
          end
        end
      end

      skeleton
    end # end #structure
  end
end
