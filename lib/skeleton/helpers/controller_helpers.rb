require 'skeleton/structure'

module Skeleton
  module Helpers
    module ControllerHelpers
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def define_api_path(resource, &block)
          Skeleton.config.structure.path(resource, &block)
        end

        def define_global_parameter(location, name, &block)
          Skeleton.config.structure.parameter(location, name, &block)
        end
      end
    end
  end
end
