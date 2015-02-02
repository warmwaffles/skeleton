require 'multi_json'

module Skeleton
  module Serializers
    class Swagger
      attr_reader :structure

      def initialize(structure)
        @structure = structure
      end

      def to_json(*)
        MultiJson.dump(to_h)
      end

      def to_h
        hash = {
          swagger: '2.0',
          info: {
            title: structure.title,
            description: structure.description,
            version: structure.version,
            termsOfService: structure.terms,
            contact: {
              name: structure.contact.name,
              email: structure.contact.email,
              url: structure.contact.url
            },
            license: {
              name: structure.license.name,
              url: structure.license.url
            }
          },
          basePath: structure.base_path,
          host: structure.host,
          schemes: structure.schemes.map(&:to_s),
          consumes: structure.consumes.map(&:to_s),
          produces: structure.produces.map(&:to_s)
        }

        if structure.parameters?
          hash[:parameters] = {}
          structure.parameters.each do |name, parameter|
            hash[:parameters][name] = parameter_to_h(parameter)
          end
        end

        if structure.responses?
          hash[:responses] = {}
          structure.responses.each do |name, response|
            hash[:responses][name] = response_to_h(response)
          end
        end

        if structure.secure?
          hash[:securityDefinitions] = {},
          hash[:security] = []
        end

        hash[:tags] = structure.tags.map do |name, tag|
          sub = {
            name: name
          }
          sub[:description] = tag.description if tag.description?
          sub[:externalDocs] = tag.external_docs if tag.external_docs?
          sub
        end

        if structure.external_docs
          hash[:externalDocs] = structure.external_docs
        end

        hash[:paths] = {}
        structure.paths.each do |resource, path|
          hash[:paths][resource] = {}

          path.operations.each do |verb, operation|
            hash[:paths][resource][verb] = operation_to_h(operation)
          end
        end

        hash[:definitions] = {}
        structure.models.each do |name, model|
          hash[:definitions][name] = schema_to_h(model)
        end

        hash
      end

      private

      def definition_ref(name)
        '#/definitions/%s' % [name]
      end

      def parameter_to_h(parameter)
        hash = {
          name: parameter.name,
          in: parameter.location,
          required: parameter.required?
        }.merge(schema_to_h(parameter))
        hash[:schema] = schema_to_h(parameter.schema) if parameter.schema?
        hash
      end

      def items_to_h(items)
        return nil if items.nil?
        hash = {
          type: items.type
        }
        hash[:format] = items.format if items.format?
        if items.array?
          hash[:items] = items_to_h(items)
          hash[:collectionFormat] = items.collection_format
        end
        hash.merge(schema_to_h(items))
        hash
      end

      def schema_to_h(schema)
        hash = {}
        hash['$ref']            = definition_ref(schema.ref) if schema.ref?
        hash[:description]      = schema.description         if schema.description?
        hash[:default]          = schema.default             if schema.default?
        hash[:maximum]          = schema.maximum             if schema.maximum?
        hash[:exclusiveMaximum] = !!schema.exclusive_maximum if schema.exclusive_maximum?
        hash[:minimum]          = schema.minimum             if schema.minimum?
        hash[:exclusiveMinimum] = !!schema.exclusive_minimum if schema.exclusive_minimum?
        hash[:maxLength]        = schema.max_length          if schema.max_length?
        hash[:minLength]        = schema.min_length          if schema.min_length?
        hash[:pattern]          = schema.pattern             if schema.pattern?
        hash[:maxItems]         = schema.max_items           if schema.max_items?
        hash[:minItems]         = schema.min_items           if schema.min_items?
        hash[:uniqueItems]      = !!schema.unique_items      if schema.unique_items?
        hash[:enum]             = schema.enum.map(&:to_s)    unless schema.enum.empty?
        hash[:multipleOf]       = schema.multiple_of         if schema.multiple_of?
        hash[:type]             = schema.type                if schema.type

        if schema.properties?
          hash[:properties] = {}
          schema.properties.each do |name, prop|
            hash[:properties][name] = schema_to_h(prop)
          end
        end

        if schema.items?
          hash[:items] = schema_to_h(schema.items)
        end
        hash
      end

      def response_to_h(response)
        hash = {
          description: response.description
        }
        if response.schema?
          hash[:schema] = schema_to_h(response.schema)
        end

        hash[:headers] = {}
        response.headers.each do |field, header|
          hash[:headers][field] = schema_to_h(header)
        end
      end

      def operation_to_h(operation)
        hash = {
          tags: operation.tags,
          summary: operation.summary,
          description: operation.description,
          responses: {}
        }

        hash[:operationId] = operation.id if operation.id?
        hash[:consumes] = operation.consumes if operation.consumes?
        hash[:produces] = operation.produces if operation.produces?

        operation.responses.each do |status, response|
          hash[:responses][status] = response_to_h(response)
        end

        if operation.parameters?
          hash[:parameters] = operation.parameters.map do |parameter|
            parameter_to_h(parameter)
          end
        end

        hash
      end

    end
  end
end
