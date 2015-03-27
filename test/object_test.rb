require_relative 'test_helper'

class ObjectTest < Minitest::Test
  def setup
    load File.expand_path('../../lib/defekt/object.rb', __FILE__) # Defekt Object
  end

  def teardown
    load 'minitest/mock.rb' # Minitest Object
  end

  def test_stub
    object = Object.new

    # non-existing method
    refute_respond_to object, :foo
    object.stub(:foo, 'bar') do
      assert_respond_to object, :foo
      assert_includes object.singleton_methods, :foo
      assert_equal 'bar', object.foo
    end
    refute_respond_to object, :foo
    refute_includes object.singleton_methods, :foo
    assert_raises(NoMethodError) { object.foo }

    # singleton method
    def object.baz; 'quux'; end
    assert_respond_to object, :baz
    assert_equal 'quux', object.baz
    object.stub(:baz, 'stubbed baz') do
      assert_respond_to object, :baz
      assert_includes object.singleton_methods, :baz
      assert_includes object.singleton_methods, :__original_baz__
      assert_equal 'stubbed baz', object.baz
      assert_equal 'quux', object.__original_baz__
    end
    assert_respond_to object, :baz
    assert_includes object.singleton_methods, :baz
    refute_includes object.singleton_methods, :__original_baz__
    assert_equal 'quux', object.baz
    assert_raises(NoMethodError) { object.__original_baz__ }

    # instance method
    assert_respond_to object, :nil?
    refute object.nil?
    object.stub(:nil?, true) do
      assert_respond_to object, :nil?
      assert_includes object.singleton_methods, :nil?
      assert object.nil?
      assert object.nil?(1, 2, 3, 4, 5)
    end
    assert_respond_to object, :nil?
    refute_includes object.singleton_methods, :nil?
    refute object.nil?
  end
end
