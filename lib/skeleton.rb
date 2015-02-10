require 'skeleton/version'
require 'skeleton/structure'
require 'skeleton/serializers/swagger'
require 'skeleton/serializers/options'

module Skeleton
  # Allows you to build a skeleton structure from within a block
  #
  # @return [Skeleton::Structure]
  def self.build(&block)
    structure = Skeleton::Structure.new
    yield(structure) if block
    structure
  end
end

