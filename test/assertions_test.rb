require_relative 'test_helper'

class Defekt::AssertionsTest < Minitest::Test
  Fake = Class.new { include Defekt::Assertions }

  def setup
    @object = Fake.new
  end

  def test_module
    assert_instance_of Module, Defekt::Assertions
  end

  def test_true!
    e = assert_raises(Defekt::Errors::TrueError) { @object.true!(false) }
    assert_equal '~false~ is not true (TrueError)', e.message
    assert_nil @object.true!(true)
  end

  def test_equal_to!
    e = assert_raises(Defekt::Errors::EqualToError) { @object.equal_to!(1, 2) }
    assert_equal '~2~ is not equal to 1 (EqualToError)', e.message
    assert_nil @object.equal_to!(1, 1)
  end

  def test_identical_to!
    e = assert_raises(Defekt::Errors::IdenticalToError) { @object.identical_to!('1', '1') }
    assert_equal '~1~ is not identical to 1 (IdenticalToError)', e.message
    assert_nil @object.identical_to!(1, 1)
  end

  def test_included_in!
    e = assert_raises(Defekt::Errors::IncludedInError) { @object.included_in!([], 1) }
    assert_equal '~1~ is not included in [] (IncludedInError)', e.message
    assert_nil @object.included_in!([1], 1)
  end

  def test_instance_of!
    e = assert_raises(Defekt::Errors::InstanceOfError) { @object.instance_of!(String, 1) }
    assert_equal '~1~ is not an instance of String (InstanceOfError)', e.message
    assert_nil @object.instance_of!(String, '1')
  end

  def test_kind_of!
    e = assert_raises(Defekt::Errors::KindOfError) { @object.kind_of!(String, 1) }
    assert_equal '~1~ is not a kind of String (KindOfError)', e.message
    assert_nil @object.kind_of!(String, '1')
    assert_nil @object.kind_of!(Object, '1')
  end
end
