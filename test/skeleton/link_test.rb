require 'test_helper'

require 'skeleton/link'

module Skeleton
  class LinkTest < Minitest::Test
    def setup
      @link = Link.new(rel: 'self', name: 'Self', href: 'http://example.org')
    end

    def test_initialize
      assert_raises(ArgumentError) do
        Link.new
      end
      assert_raises(ArgumentError) do
        Link.new(rel: 'self')
      end

      Link.new(rel: 'self', href: 'http://example.org')
    end

    def test_method_missing
      assert_raises(NoMethodError) do
        @link.foo
      end

      @link = Link.new(rel: 'self', href: 'http://example.org', foo: 'bar')
      assert_equal('bar', @link.foo)
    end

    def test_templated?
      refute(@link.templated?)
      @link.templated = 'asdf'
      assert(@link.templated?)
      @link.templated = false
      refute(@link.templated?)
    end

    def test_comparable
      other = Link.new(rel: 'self', name: 'Self', href: 'http://example.org')
      assert_equal(0, other <=> @link)

      before = Link.new(rel: 'other', href: 'http://example.org')
      assert_equal(-1, before <=> @link)

      after = Link.new(rel: 'zoo', href: 'http://example.org')
      assert_equal(1, after <=> @link)
    end

    def test_eql?
      other = Link.new(rel: 'self', name: 'Self', href: 'http://example.org')
      assert(@link.eql?(other))

      other = Link.new(rel: 'other', href: 'http://example.org')
      refute(@link.eql?(other))

      other = Object.new
      refute(@link.eql?(other))
    end

    def test_to_h
      hash = @link.to_h
      assert_equal('self', hash['rel'])
      assert_equal('Self', hash['name'])
      assert_equal('http://example.org', hash['href'])
    end
  end
end
