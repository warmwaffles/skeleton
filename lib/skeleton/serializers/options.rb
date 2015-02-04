require 'multi_json'

module Skeleton
  module Serializers
    class Options
      attr_reader :structure

      def initialize(structure, options={})
        @structure = structure

        @path        = options[:path] || raise(ArgumentError, ':path is required')
        @definitions = options[:definitions] || '#/definitions'
      end

      def to_json(*)
        MultiJson.dump(to_h)
      end

      def to_h
        hash = {
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
          hash[:security_definitions] = {},
          hash[:security] = []
        end

        hash[:tags] = structure.tags.map do |name, tag|
          sub = {
            name: name
          }
          sub[:description] = tag.description if tag.description?
          sub[:external_docs] = tag.external_docs if tag.external_docs?
          sub
        end

        path = structure.paths.fetch(@path)
        hash[:operations] ||= {}
        path.operations.each do |verb, operation|
          hash[:operations][verb] = operation_to_h(operation)
        end

        # Need to loop through to ensure that we gather all of the requirements
        # and add them to the definitions map
        hash[:definitions] = {}
        required_definitions.each do |name|
          hash[:definitions][name] = schema_to_h(structure.models[name])
        end

        hash
      end

      def required_definitions
        @required_definitions ||= Set.new
      end

      def require_definition(schema)
        if required_definitions.include?(schema.ref)
          return false
        else
          required_definitions.add(schema.ref)
        end

        required_definitions.merge(references_for(schema))
      end

      def references_for(schema)
        refs = Set.new

        if schema.ref?
          refs.add(schema.ref)
          referenced = structure.models[schema.ref]
          refs.merge references_for(referenced)
        end

        schema.properties.each do |name, property|
          refs.merge(references_for(property))
        end

        if schema.items? && schema.items.ref?
          refs.add(schema.items.ref)
        end

        refs
      end

      def definition_ref(name)
        '%s/%s' % [@definitions, name]
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

        if schema.ref?
          hash['$ref'] = definition_ref(schema.ref)
          require_definition(schema)
        end

        hash[:description]       = schema.description         if schema.description?
        hash[:default]           = schema.default             if schema.default?
        hash[:maximum]           = schema.maximum             if schema.maximum?
        hash[:exclusive_maximum] = !!schema.exclusive_maximum if schema.exclusive_maximum?
        hash[:minimum]           = schema.minimum             if schema.minimum?
        hash[:exclusive_minimum] = !!schema.exclusive_minimum if schema.exclusive_minimum?
        hash[:max_length]        = schema.max_length          if schema.max_length?
        hash[:min_length]        = schema.min_length          if schema.min_length?
        hash[:pattern]           = schema.pattern             if schema.pattern?
        hash[:max_items]         = schema.max_items           if schema.max_items?
        hash[:min_items]         = schema.min_items           if schema.min_items?
        hash[:unique_items]      = !!schema.unique_items      if schema.unique_items?
        hash[:enum]              = schema.enum.map(&:to_s)    unless schema.enum.empty?
        hash[:multiple_of]       = schema.multiple_of         if schema.multiple_of?
        hash[:type]              = schema.type                if schema.type

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
        hash
      end

      def operation_to_h(operation)
        hash = {
          tags: operation.tags,
          summary: operation.summary,
          description: operation.description,
          responses: {}
        }

        hash[:operation_id] = operation.id if operation.id?
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
