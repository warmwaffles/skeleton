require 'spec_helper'

require 'skeleton/operation'

describe Skeleton::Operation do
  describe '#summary=' do
    it 'sets the summary' do
      operation = Skeleton::Operation.new
      operation.summary = 'foo bar'
      assert_equal('foo bar', operation.summary)
    end
  end

  describe '#summary?' do
    context 'when not set' do
      it 'returns false' do
        operation = Skeleton::Operation.new
        refute(operation.summary?)
      end
    end

    context 'when set' do
      it 'returns true' do
        operation = Skeleton::Operation.new(summary: 'foo bar')
        assert(operation.summary?)
      end
    end
  end

  describe '#consumes' do
    context 'when not set' do
      it 'returns an empty array' do
        operation = Skeleton::Operation.new
        assert_empty(operation.consumes)
      end
    end

    context 'when set' do
      it 'returns strings' do
        operation = Skeleton::Operation.new({consumes: ['application/json', 'application/xml']})
        assert_includes(operation.consumes, 'application/json')
        assert_includes(operation.consumes, 'application/xml')
      end
    end
  end

  describe '#consumes?' do
    context 'when not set' do
      it 'returns an empty array' do
        operation = Skeleton::Operation.new
        refute(operation.consumes?)
      end
    end

    context 'when set' do
      it 'returns strings' do
        operation = Skeleton::Operation.new({consumes: ['application/json', 'application/xml']})
        assert(operation.consumes?)
      end
    end
  end

  describe '#produces' do
    context 'when not set' do
      it 'returns an empty array' do
        operation = Skeleton::Operation.new
        assert_empty(operation.produces)
      end
    end

    context 'when set' do
      it 'returns strings' do
        operation = Skeleton::Operation.new({produces: ['application/json', 'application/xml']})
        assert_includes(operation.produces, 'application/json')
        assert_includes(operation.produces, 'application/xml')
      end
    end
  end

  describe '#produces?' do
    context 'when not set' do
      it 'returns an empty array' do
        operation = Skeleton::Operation.new
        refute(operation.produces?)
      end
    end

    context 'when set' do
      it 'returns strings' do
        operation = Skeleton::Operation.new({produces: ['application/json', 'application/xml']})
        assert(operation.produces?)
      end
    end
  end

  describe '#to_h' do
    context 'when nothing is set' do
      it 'returns an empty hash' do
        operation = Skeleton::Operation.new
        assert_empty(operation.to_h)
      end
    end

    context 'when consumes is set' do
      it 'returns a hash with the consumes field' do
        operation = Skeleton::Operation.new({consumes: ['application/json', 'application/xml']})
        hash = operation.to_h
        refute_empty(hash, 'expected the hash to contain data')
        assert(hash.key?(:consumes), 'expected the hash to contain :consumes')
      end
    end
  end
end
