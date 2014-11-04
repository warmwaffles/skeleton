require 'spec_helper'

require 'skeleton/header'

describe Skeleton::Header do
  before do
    @header = Skeleton::Header.new
  end

  describe '#exclusive_maximum?' do
    describe 'when set' do
      it 'is true' do
        @header.exclusive_maximum = 10
        assert(@header.exclusive_maximum?)
      end
    end

    describe 'when not set' do
      it 'is false' do
        @header.exclusive_maximum = nil
        refute(@header.exclusive_maximum?)
      end
    end
  end

  describe '#exclusive_minimum?' do
    describe 'when set' do
      it 'is true' do
        @header.exclusive_minimum = 10
        assert(@header.exclusive_minimum?)
      end
    end

    describe 'when not set' do
      it 'is false' do
        @header.exclusive_minimum = nil
        refute(@header.exclusive_minimum?)
      end
    end
  end

  describe '#unique_items?' do
    describe 'when set' do
      it 'is true' do
        @header.unique_items = 10
        assert(@header.unique_items?)
      end
    end

    describe 'when not set' do
      it 'is false' do
        @header.unique_items = nil
        refute(@header.unique_items?)
      end
    end
  end
end
