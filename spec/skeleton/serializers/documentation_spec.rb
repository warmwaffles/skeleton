require 'spec_helper'

require 'skeleton/documentation'

describe Skeleton::Documentation do
  before do
    @documentation = Skeleton::Documentation.new
  end

  describe '#description=' do
    it 'sets the description' do
      @documentation.description = 'foo'
      assert_equal('foo', @documentation.description)
    end
  end

  describe '#url=' do
    it 'sets the url' do
      @documentation.url = 'foo'
      assert_equal('foo', @documentation.url)
    end
  end
end
