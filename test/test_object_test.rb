require_relative 'test_helper'

class Defekt::TestObjectTest < Minitest::Test
  def setup
    @pass = Defekt::TestObject.new(FakeTest.instance_method(:test_passes))
    @fail = Defekt::TestObject.new(FakeTest.instance_method(:test_fails))
    @error = Defekt::TestObject.new(FakeTest.instance_method(:test_errors))
  end

  def test_initialize
    assert_instance_of Defekt::TestObject, @pass
  end

  def test_methot
    assert_instance_of UnboundMethod, @pass.methot
  end

  def test_exception
    assert_nil @pass.exception

    @pass.instance_variable_set(:@exception, StandardError.new)
    assert_equal StandardError.new, @pass.exception
  end

  def test_klass
    assert_equal FakeTest, @pass.klass
  end

  def test_object
    assert_instance_of FakeTest, @pass.object
  end

  def test_location
    assert_instance_of String, @pass.location
    assert_includes @pass.location, 'test/support/fake_test.rb:12'
  end

  def test_run
    assert_equal '.', @pass.run
    assert_equal 'f', @fail.run
    assert_equal 'e', @error.run
  end

  def test_before_and_after
    @pass.run # run with original before and after
    assert_equal 'after', @pass.object.feedback

    stubbed_fail_object = FakeTest.new
    stub(stubbed_fail_object, :after, nil)
    stub(@fail, :object, stubbed_fail_object)
    @fail.run # run with original before and stubbed after
    assert_equal 'before', @fail.object.feedback

    stubbed_error_object = FakeTest.new
    stub(stubbed_error_object, :before, nil)
    stub(stubbed_error_object, :after, nil)
    stub(@error, :object, stubbed_error_object)
    @error.run # run with stubbed before and stubbed after
    assert_nil @error.object.feedback
  end

  def test_ran?
    refute @pass.ran?

    @pass.instance_variable_set(:@ran, true)
    assert @pass.ran?
  end

  def test_passed?
    refute @pass.passed?

    stub(@pass, :ran?, true)
    assert @pass.passed?
  end

  def test_failed?
    refute @fail.failed?

    stub(@fail, :ran?, true)
    stub(@fail, :exception, Defekt::Exceptions::TestError.new)
    assert @fail.failed?
  end

  def test_errored?
    refute @error.errored?

    stub(@error, :ran?, true)
    stub(@error, :exception, StandardError.new)
    assert @error.errored?
  end

  def test_report
    stub(@fail, :ran?, true)
    stub(@fail, :exception, Defekt::Exceptions::TestError.new)
    assert_instance_of String, @fail.report
  end
end
