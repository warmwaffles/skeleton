require 'spec_helper'

require 'skeleton/contact'

describe Skeleton::Contact do
  before do
    @contact = Skeleton::Contact.new
  end

  describe '#name=' do
    it 'sets the name' do
      @contact.name = 'foo'
      assert_equal('foo', @contact.name)
    end
  end

  describe '#email=' do
    it 'sets the email' do
      @contact.email = 'foo'
      assert_equal('foo', @contact.email)
    end
  end

  describe '#url=' do
    it 'sets the url' do
      @contact.url = 'foo'
      assert_equal('foo', @contact.url)
    end
  end
end
