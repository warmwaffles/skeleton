require 'set'
require 'tsort'

module Skeleton
  class Graph
    include Enumerable
    include TSort

    def initialize
      @dep = Hash.new { |h,k| h[k] = Set.new }
    end

    # Register a dependency
    #
    # @param base [Object] the base object
    # @param list [Object,Array] list of dependents
    def register(base, *list)
      dependents = Array(list).flatten
      @dep[base] ||= Set.new
      @dep[base].merge(dependents)
    end

    # Iterate over each of the nodes in this graph with their edge
    #
    # @return [void]
    def each(&block)
      @dep.each do |base, set|
        set.each do |name|
          yield(base, name) if block
        end
      end
    end

    # Takes all of the nodes in this graph and creates a set with them
    #
    # @return [Set]
    def to_set
      set = Set.new
      @dep.each do |base, deps|
        set.add(base)
        set.merge(deps)
      end
      set
    end

    def each_dependent_for(base, &block)
      each_strongly_connected_component_from(base) do |dependent, _|
        yield(dependent)
      end
    end

    def tsort_each_child(node, &block)
      @dep[node].each(&block)
    end
  end
end
