require_relative 'test_helper'

class Defekt::CollectionTest < Minitest::Test
  def setup
    @collection = Defekt::Collection.new(FakeTest)
  end

  def test_initialize
    assert_instance_of Defekt::Collection, @collection
  end

  def test_all
    stub(FakeTest, :descendants, [FakeTest])
    assert_instance_of Array, @collection.all
    assert_instance_of Defekt::TestObject, @collection.all.first
    assert_instance_of UnboundMethod, @collection.all.first.methot
    all_tests = [:test_passes, :test_fails, :test_errors]
    assert_equal all_tests, @collection.all.map(&:methot).map(&:name)
  end
end
