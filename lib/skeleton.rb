require 'skeleton/version'
require 'skeleton/structure'
require 'skeleton/config'
require 'skeleton/helpers/controller_helpers'

def skeleton_rails? 
  Gem::Specification::find_all_by_name('rails').any?
end

if skeleton_rails?
  require 'rails'
  require 'skeleton/engine'
end

module Skeleton
  def self.build(&block)
    structure = Skeleton::Structure.new
    yield(structure) if block
    structure
  end

  def self.config
    @config ||= Skeleton::Config.new
  end

  def self.configure(&block)
    yield(config) if block
  end
end
