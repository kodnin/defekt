require_relative 'test_helper'

class Defekt::CollectionTest < Minitest::Test
  def setup
    @collection = Defekt::Collection.new(FakeTest)
    FakeTest.stub :descendants, [FakeTest] do
      @collection.all.each(&:run) # memoize collection with stubbed descendants and run
    end
  end

  def test_initialize
    assert_instance_of Defekt::Collection, @collection
  end

  def test_all
    assert_instance_of Array, @collection.all
    assert_instance_of Defekt::Test, @collection.all.first
    assert_instance_of UnboundMethod, @collection.all.first.methot
    all_tests = [:test_passes, :test_fails, :test_errors]
    assert_equal all_tests, @collection.all.map(&:methot).map(&:name)
  end

  def test_passed
    collection = @collection.passed.map(&:methot).map(&:name)
    assert_includes collection, :test_passes
    refute_includes collection, :test_fails
    refute_includes collection, :test_errors
  end

  def test_failed
    collection = @collection.failed.map(&:methot).map(&:name)
    assert_includes collection, :test_fails
    refute_includes collection, :test_passes
    refute_includes collection, :test_errors
  end

  def test_errored
    collection = @collection.errored.map(&:methot).map(&:name)
    assert_includes collection, :test_errors
    refute_includes collection, :test_passes
    refute_includes collection, :test_fails
  end

  def test_broken
    collection = @collection.broken.map(&:methot).map(&:name)
    assert_includes collection, :test_fails
    assert_includes collection, :test_errors
    refute_includes collection, :test_passes
  end
end
