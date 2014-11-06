# Skeleton

Was born from the desire for api documentation that can live along side actively
running code.

## Example

```ruby
# You would put this somewhere such as config/initializers/skeleton.rb
Skeleton.configure do |config|
  config.define do |structure|
    structure.host = 'api.example.com'
    structure.base_path = '/foo'

    structure.schemes = %w(https)
    structure.consumes = %(application/json)
    structure.produces = %(application/json)
  end

  config.info do |info|
    info.version = '1.0.6'
    info.title = 'An Example API'
    info.description = 'An api to interact with data'
    info.terms_of_service = 'https://api.example.com/terms/'
  end

  config.contact do |contact|
    contact.name = 'WarmWaffles'
    contact.email = 'warmwaffles@gmail.com'
    contact.url = 'https://github.com/warmwaffles/skeleton'
  end

  config.license do |license|
    license.name = 'MIT'
  end
end
```

Inside of your rails controller you would do the following

```ruby
class ApplicationController < ActionController::Base
  include Skeleton::Helpers::ControllerHelpers
end
```

Inside a controller that you wish to document do the following

```ruby
class AccountsController < ApplicationController
  define_api_path('/accounts') do |path|
    path.get do |operation|
      operation.tag('account')
      operation.description = 'List all of the accounts available to you'

      operation.parameter(:query, 'limit') do |p|
        p.description = 'maximum number of results to return'
        p.type = 'integer'
        p.format = 'int32'
        p.required = false
      end
      operation.parameter(:query, 'offset') do |p|
        p.description = 'offset within the results returned'
        p.type = 'integer'
        p.format = 'int32'
        p.required = false
      end
    end
  end

  define_api_path('/accounts/{account_id}') do |path|
    path.get do |operation|
      operation.tag('account')
      operation.description = 'Get an account'
      operation.parameter(:query, 'account_id') do |p|
        p.description = 'The account id'
        p.type = 'string'
        p.format = 'uuid'
        p.required = true
      end
    end

    path.options do |operation|
      operation.tag('account')
      operation.description = 'Show available options for the account'
      operation.parameter(:query, 'account_id') do |p|
        p.description = 'The account id'
        p.type = 'string'
        p.format = 'uuid'
        p.required = true
      end
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
        render(json: Skeleton.config.to_swagger_json, status: 200)
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
