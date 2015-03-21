require_relative 'test_helper'

class Defekt::BaseClassTest < Minitest::Test
  This = Class.new(Defekt::BaseClass)
  That = Class.new(This)

  def setup
    @class = Defekt::BaseClass
  end

  def test_class
    assert_instance_of Class, @class
  end

  def test_children
    assert_instance_of Array, @class.children
    assert_equal [This], @class.children
    assert_equal [That], This.children
    assert_equal [], That.children
  end

  def test_descendants
    assert_instance_of Array, @class.descendants
    assert_equal [This, That], @class.descendants
    assert_equal [That], This.descendants
    assert_equal [], That.descendants
  end
end
