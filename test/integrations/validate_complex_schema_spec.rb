require 'test_helper'
require 'multi_json'
require 'json-schema'

require 'skeleton/serializers/swagger'

describe 'Validate complex schemas' do
  context 'KISSmetrics Core API' do
    it 'conforms to the Swagger v2.0 Schema' do
      # JSON Validator will reach out and grab this draft. This is to avoid
      # the intermittent errors that occur
      stub_request(:get, "http://json-schema.org/draft-04/schema")
        .to_return({
          status: 200,
          body: Fixtures.read('json-schema-draft-04.json')
        })

      structure = KISSmetrics::CoreAPI.structure
      hash = Skeleton::Serializers::Swagger.new(structure).to_h
      schema = MultiJson.load(Fixtures.read('schema.json'))

      errors = JSON::Validator.fully_validate(schema, hash, :errors_as_objects => true)

      unless errors.empty?
        messages = [
          "JSON Validation Failed",
          "Errors: #{errors.length}"
        ]

        errors.each do |e|
          messages << '  '.concat(e[:message])
          messages << '    => '.concat(e[:fragment])
          messages << '    => '.concat(e[:failed_attribute])
          messages << '    => '.concat(e[:schema])
          messages << ''
        end

        fail(messages.join("\n"))
      end
    end
  end
end
