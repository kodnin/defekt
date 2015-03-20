require_relative 'test_helper'

class Defekt::TestClassTest < Minitest::Test
  This = Class.new(Defekt::TestClass)
  That = Class.new(This)

  def setup
    @test_class = Defekt::TestClass
  end

  def test_class
    assert_instance_of Class, @test_class
  end

  def test_children
    assert_instance_of Array, @test_class.children
    assert_equal [This], @test_class.children
    assert_equal [That], This.children
    assert_equal [], That.children
  end

  def test_descendants
    assert_instance_of Array, @test_class.descendants
    assert_equal [This, That], @test_class.descendants
    assert_equal [That], This.descendants
    assert_equal [], That.descendants
  end
end
