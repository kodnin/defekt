require_relative 'test_helper'

class Defekt::CollectionTest < Minitest::Test
  def setup
    stub(FakeTest, :descendants, [FakeTest])
    @collection = Defekt::Collection.new(FakeTest)
    @collection.all.each(&:run)
  end

  def test_initialize
    assert_instance_of Defekt::Collection, @collection
  end

  def test_all
    assert_instance_of Array, @collection.all
    assert_instance_of Defekt::BaseObject, @collection.all.first
    assert_instance_of UnboundMethod, @collection.all.first.methot
    all_tests = [:test_passes, :test_fails, :test_errors]
    assert_equal all_tests, @collection.all.map(&:methot).map(&:name)
  end

  def test_passed
    assert_includes @collection.passed.map(&:methot).map(&:name), :test_passes
    refute_includes @collection.passed.map(&:methot).map(&:name), :test_fails
    refute_includes @collection.passed.map(&:methot).map(&:name), :test_errors
  end

  def test_failed
    assert_includes @collection.failed.map(&:methot).map(&:name), :test_fails
    refute_includes @collection.failed.map(&:methot).map(&:name), :test_passes
    refute_includes @collection.failed.map(&:methot).map(&:name), :test_errors
  end

  def test_errored
    assert_includes @collection.errored.map(&:methot).map(&:name), :test_errors
    refute_includes @collection.errored.map(&:methot).map(&:name), :test_passes
    refute_includes @collection.errored.map(&:methot).map(&:name), :test_fails
  end

  def test_defekt
    assert_includes @collection.defekt.map(&:methot).map(&:name), :test_fails
    assert_includes @collection.defekt.map(&:methot).map(&:name), :test_errors
    refute_includes @collection.defekt.map(&:methot).map(&:name), :test_passes
  end
end
