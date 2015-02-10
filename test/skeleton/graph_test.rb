require 'test_helper'

require 'skeleton/graph'

module Skeleton
  class GraphTest < Minitest::Test
    def test_integration
      graph = Skeleton::Graph.new
      graph.register('Accounts', ['Meta', 'AccountData', 'Link'])
      graph.register('Meta', 'Error')
      graph.register('Error', 'Error')
      graph.register('Accounts', 'AccountData')
      graph.register('AccountData', 'Contact')
      graph.register('Accounts', 'Link')

      expected = Set.new(%w(Accounts Meta AccountData Link Contact Error))
      actual = Set.new
      graph.each_dependent_for('Accounts') { |n| actual.add(n) }
      assert_equal(expected, actual)
    end
  end
end
