require_relative 'test_helper'

class Defekt::AssertionsTest < Minitest::Test
  FakeTest = Class.new { include Defekt::Assertions }
  FakeMock = Class.new { def verify; end }

  def setup
    @object = FakeTest.new
  end

  def test_module
    assert_instance_of Module, Defekt::Assertions
  end

  def test_true!
    e = assert_raises(Defekt::Errors::TrueError) { @object.true!(false) }
    assert_equal 'false is not true (TrueError)', e.message
    assert_nil @object.true!(true)
  end

  def test_not_true!
    e = assert_raises(Defekt::Errors::NotTrueError) { @object.not_true!(true) }
    assert_equal 'true is true (NotTrueError)', e.message
    assert_nil @object.not_true!(false)
  end

  def test_nil!
    e = assert_raises(Defekt::Errors::NilError) { @object.nil!(1) }
    assert_equal '1 is not nil (NilError)', e.message
    assert_nil @object.nil!(nil)
  end

  def test_not_nil!
    e = assert_raises(Defekt::Errors::NotNilError) { @object.not_nil!(nil) }
    assert_equal 'nil is nil (NotNilError)', e.message
    assert_nil @object.not_nil!(1)
  end

  def test_equal_to!
    e = assert_raises(Defekt::Errors::EqualToError) { @object.equal_to!(1, 2) }
    assert_equal '2 is not equal to 1 (EqualToError)', e.message
    assert_nil @object.equal_to!(1, 1)
  end

  def test_not_equal_to!
    e = assert_raises(Defekt::Errors::NotEqualToError) { @object.not_equal_to!(1, 1) }
    assert_equal '1 is equal to 1 (NotEqualToError)', e.message
    assert_nil @object.not_equal_to!(1, 2)
  end

  def test_identical_to!
    e = assert_raises(Defekt::Errors::IdenticalToError) { @object.identical_to!('1', '1') }
    assert_equal '"1" is not identical to "1" (IdenticalToError)', e.message
    assert_nil @object.identical_to!(1, 1)
  end

  def test_not_identical_to!
    e = assert_raises(Defekt::Errors::NotIdenticalToError) { @object.not_identical_to!(1, 1) }
    assert_equal '1 is identical to 1 (NotIdenticalToError)', e.message
    assert_nil @object.not_identical_to!('1', '1')
  end

  def test_instance_of!
    e = assert_raises(Defekt::Errors::InstanceOfError) { @object.instance_of!(String, 1) }
    assert_equal '1 is not an instance of String (InstanceOfError)', e.message
    assert_nil @object.instance_of!(String, '1')
  end

  def test_not_instance_of!
    e = assert_raises(Defekt::Errors::NotInstanceOfError) { @object.not_instance_of!(String, '1') }
    assert_equal '"1" is an instance of String (NotInstanceOfError)', e.message
    assert_nil @object.not_instance_of!(String, 1)
  end

  def test_kind_of!
    e = assert_raises(Defekt::Errors::KindOfError) { @object.kind_of!(String, 1) }
    assert_equal '1 is not a kind of String (KindOfError)', e.message
    assert_nil @object.kind_of!(String, '1')
    assert_nil @object.kind_of!(Object, '1')
  end

  def test_not_kind_of!
    e = assert_raises(Defekt::Errors::NotKindOfError) { @object.not_kind_of!(Object, '1') }
    assert_equal '"1" is a kind of Object (NotKindOfError)', e.message
    assert_nil @object.not_kind_of!(Fixnum, '1')
    assert_nil @object.not_kind_of!(Integer, '1')
  end

  def test_respond_to!
    e = assert_raises(Defekt::Errors::RespondToError) { @object.respond_to!(1, :foo) }
    assert_equal '1 does not respond to :foo (RespondToError)', e.message
    assert_nil @object.respond_to!(1, :class)
  end

  def test_not_respond_to!
    e = assert_raises(Defekt::Errors::NotRespondToError) { @object.not_respond_to!(1, :class) }
    assert_equal '1 does respond to :class (NotRespondToError)', e.message
    assert_nil @object.not_respond_to!(1, :foo)
  end

  def test_included_in!
    e = assert_raises(Defekt::Errors::IncludedInError) { @object.included_in!([], 1) }
    assert_equal '1 is not included in [] (IncludedInError)', e.message
    assert_nil @object.included_in!([1], 1)
  end

  def test_not_included_in!
    e = assert_raises(Defekt::Errors::NotIncludedInError) { @object.not_included_in!([1], 1) }
    assert_equal '1 is included in [1] (NotIncludedInError)', e.message
    assert_nil @object.not_included_in!([], 1)
  end

  def test_verify!
    mock = FakeMock.new
    mock.stub(:verify, false) do
      e = assert_raises(Defekt::Errors::MockExpectationError) { @object.verify!(mock) }
      assert_equal 'mock expectation not met (MockExpectationError)', e.message
    end
    mock.stub(:verify, true) do
      assert_nil @object.verify!(mock)
    end
  end
end
