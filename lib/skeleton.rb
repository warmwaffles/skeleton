require 'skeleton/version'
require 'skeleton/structure'

module Skeleton
  def self.build(&block)
    structure = Skeleton::Structure.new
    yield(structure) if block
    structure
  end
end

require 'skeleton/serializers/swagger'
require 'skeleton/serializers/options'
