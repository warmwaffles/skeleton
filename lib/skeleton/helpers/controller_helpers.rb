require 'skeleton/structure'

module Skeleton
  module Helpers
    module ControllerHelpers
      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def define_api_path(resource, &block)
          Skeleton.config.path(resource, &block)
        end

        def define_global_parameter(location, name, &block)
          Skeleton.config.parameter(location, name, &block)
        end
      end

      def get_api_path(resource)
        Skeleton.config.path(resource)
      end
    end
  end
end
