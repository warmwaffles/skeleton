# Skeleton

Was born from the desire for api documentation that can live along side actively
running code.

## Example

```ruby
# You would put this somewhere such as config/initializers/skeleton.rb
structure = Skeleton.build do |s|
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
```

## Defining models

```ruby
structure.define_model('Link') do
  describe('The link object used for api discovery')
  required(:href,      type: 'string')
  required(:rel,       type: 'string')
  optional(:templated, type: 'boolean')
  optional(:name,      type: 'string')
end

structure.define_model('Error') do
  describe('Represents an error')
  required(:message, type: 'string')
  optional(:field,   type: 'string')
  optional(:errors,  type: 'array', items: { ref: 'Error' })
end

structure.define_model('Meta') do
  describe('The meta information regarding the request')
  required(:status,  type: 'integer')
  optional(:message, type: 'string')
  optional(:errors,  type: 'array', items: { ref: 'Error' })
end
```

If you wish to reference a definition from within another model, all you need to
do is to pass a `:ref`. If you want to know more about this structure, please
see the swagger documentation.

## Defining paths

```ruby
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
```

If you want to dump the documentation to swagger you can simply do the
following:

```ruby
class DocumentationController < ApplicationController
  def swagger
    respond_to do |format|
      format.json do
        serializer = Skeleton::Serializers::Swagger.new(my_structure)
        render(json: MultiJson.dump(serializer.to_h), status: 200)
      end
    end
  end
end
```

## Testing

We are using MiniTest in order to write tests. Please follow this guideline:

  * If the test is not a unit test, it belongs under `spec`
  * If the test is a unit test, it belongs under `test`
  * Test to the best you can

```sh
rake test
```

## Contributing

  * Fork this repo
  * Do work on a separate branch
  * Submit a pull request
  * Drink a beer
