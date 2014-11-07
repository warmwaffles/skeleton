require 'multi_json'

module Skeleton
  module Serializers
    class Swagger
      attr_accessor :structure

      def initialize(args={})
        @structure = args[:structure]
        @version   = args[:version] || '2.0'
      end

      def to_hash
        hash = {
          swagger: @version,
          info: dump_info_to_json(structure.info),
          host: structure.host,
          basePath: structure.base_path,
          schemes: structure.schemes
        }

        hash[:consumes] = structure.consumes unless structure.consumes.empty?
        hash[:produces] = structure.produces unless structure.produces.empty?

        hash[:paths] = {}
        structure.paths.each do |key, path|
          hash[:paths][key] = dump_path_to_json(path)
        end

        hash
      end

      def to_json
        MultiJson.dump(to_hash)
      end

      def dump_info_to_json(info)
        hash = {}
        hash[:title]          = info.title            if info.title?
        hash[:description]    = info.description      if info.description?
        hash[:version]        = info.version          if info.version?
        hash[:termsOfService] = info.terms_of_service if info.terms_of_service?

        if info.license?
          hash[:license] = {}
          hash[:license][:name] = info.license.name if info.license.name?
          hash[:license][:url]  = info.license.url if info.license.url?
        end
        hash
      end

      def dump_path_to_json(path)
        hash = {}
        path.operations.each do |method, operation|
          hash[method] = dump_operation_to_json(operation)
        end
        hash
      end

      def dump_operation_to_json(operation)
        hash = {}
        hash[:tags]        = operation.tags        if operation.tags?
        hash[:summary]     = operation.summary     if operation.summary?
        hash[:description] = operation.description if operation.description?

        if operation.external_docs?
          hash[:externalDocs] = dump_external_docs_to_json(operation.external_docs)
        end

        hash[:operationId] = operation.operation_id if operation.operation_id?
        hash[:consumes]    = operation.consumes     if operation.consumes?
        hash[:produces]    = operation.produces     if operation.produces?

        if operation.parameters?
          hash[:parameters] = operation.parameters.map do |parameter|
            dump_parameter_to_json(parameter)
          end
        end

        hash[:responses]  = dump_response_to_json(operation.responses) if operation.responses?
        hash[:schemes]    = operation.schemes    if operation.schemes?
        hash[:deprecated] = operation.deprecated if operation.deprecated?

        if operation.security?
          hash[:security] = dump_security_to_json(operation.security)
        end

        hash
      end

      def dump_parameter_to_json(parameter)
        hash = {}

        hash[:name]        = parameter.name        if parameter.name?
        hash[:in]          = parameter.location    if parameter.location?
        hash[:description] = parameter.description if parameter.description?
        hash[:required]    = parameter.required    if parameter.required?

        if parameter.schema?
          hash[:schema] = dump_schema_to_json(parameter.schema)
        else
          hash[:type]             = parameter.type              if parameter.type?
          hash[:format]           = parameter.format            if parameter.format?
          hash[:items]            = parameter.items             if parameter.items?
          hash[:collectionFormat] = parameter.collection_format if parameter.collection_format?
          hash[:default]          = parameter.default           if parameter.default?
          hash[:maximum]          = parameter.maximum           if parameter.maximum?
          hash[:exclusiveMaximum] = parameter.exclusive_maximum if parameter.exclusive_maximum?
          hash[:minimum]          = parameter.minimum           if parameter.minimum?
          hash[:exclusiveMinimum] = parameter.exclusive_minimum if parameter.exclusive_minimum?
          hash[:maxLength]        = parameter.max_length        if parameter.max_length?
          hash[:minLength]        = parameter.min_length        if parameter.min_length?
          hash[:pattern]          = parameter.pattern           if parameter.pattern?
          hash[:maxItems]         = parameter.max_items         if parameter.max_items?
          hash[:minItems]         = parameter.min_items         if parameter.min_items?
          hash[:uniqueItems]      = parameter.unique_items      if parameter.unique_items?
          hash[:enum]             = parameter.enum              if parameter.enum?
          hash[:multipleOf]       = parameter.multiple_of       if parameter.multiple_of?
        end

        hash
      end

      def dump_external_docs_to_json(external_docs)
        hash = {}
        hash[:description] = external_docs.description if external_docs.description?
        hash[:url] = external_docs.url if external_docs.url?
        hash
      end

      def dump_security_to_json(security)
        hash = {}
        hash[:type]             = security.type
        hash[:description]      = security.description
        hash[:name]             = security.name
        hash[:in]               = security.location
        hash[:flow]             = security.flow
        hash[:authorizationUrl] = security.authorization_url
        hash[:tokenUrl]         = security.token_url
        hash[:flow]             = security.flow
        hash[:scopes]           = security.scopes
        hash
      end

      def dump_response_to_json(response)
        hash = {}
        hash[:description] = response.description
        hash[:schema]      = dump_schema_to_json(response.schema)     if response.schema?
        hash[:headers]     = dump_headers_to_json(response.headers)   if response.headers?
        hash[:examples]    = dump_examples_to_json(response.examples) if response.examples?
        hash
      end

      def dump_schema_to_json(schema)
        hash = {}
        hash[:discriminator]    = schema.discriminator     if schema.discriminator?
        hash[:readOnly]         = schema.read_only?
        hash[:externalDocs]     = schema.external_docs     if schema.external_docs?
        hash[:description]      = schema.description       if schema.description?
        hash[:examples]         = dump_examples_to_json(schema.examples) if schema.examples?
        hash[:type]             = schema.type              if schema.type?
        hash[:format]           = schema.format            if schema.format?
        hash[:items]            = schema.items             if schema.items?
        hash[:collectionFormat] = schema.collection_format if schema.collection_format?
        hash[:default]          = schema.default           if schema.default?
        hash[:maximum]          = schema.maximum           if schema.maximum?
        hash[:exclusiveMaximum] = schema.exclusive_maximum if schema.exclusive_maximum?
        hash[:minimum]          = schema.minimum           if schema.minimum?
        hash[:exclusiveMinimum] = schema.exclusive_minimum if schema.exclusive_minimum?
        hash[:maxLength]        = schema.max_length        if schema.max_length?
        hash[:minLength]        = schema.min_length        if schema.min_length?
        hash[:pattern]          = schema.pattern           if schema.pattern?
        hash[:maxItems]         = schema.max_items         if schema.max_items?
        hash[:minItems]         = schema.min_items         if schema.min_items?
        hash[:uniqueItems]      = schema.unique_items      if schema.unique_items?
        hash[:enum]             = schema.enum              if schema.enum?
        hash[:multipleOf]       = schema.multiple_of       if schema.multiple_of?
        hash
      end

      def dump_headers_to_json(header)
        hash = {}

        hash[:description]      = header.description       if header.description?
        hash[:type]             = header.type              if header.type?
        hash[:format]           = header.format            if header.format?
        hash[:items]            = header.items             if header.items?
        hash[:collectionFormat] = header.collection_format if header.collection_format?
        hash[:default]          = header.default           if header.default?
        hash[:maximum]          = header.maximum           if header.maximum?
        hash[:exclusiveMaximum] = header.exclusive_maximum if header.exclusive_maximum?
        hash[:minimum]          = header.minimum           if header.minimum?
        hash[:exclusiveMinimum] = header.exclusive_minimum if header.exclusive_minimum?
        hash[:maxLength]        = header.max_length        if header.max_length?
        hash[:minLength]        = header.min_length        if header.min_length?
        hash[:pattern]          = header.pattern           if header.pattern?
        hash[:maxItems]         = header.max_items         if header.max_items?
        hash[:minItems]         = header.min_items         if header.min_items?
        hash[:uniqueItems]      = header.unique_items      if header.unique_items?
        hash[:enum]             = header.enum              if header.enum?
        hash[:multipleOf]       = header.multiple_of       if header.multiple_of?

        hash
      end

      def dump_examples_to_json(schema)
        hash = {}
        hash
      end
    end
  end
end
