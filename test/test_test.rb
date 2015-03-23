require_relative 'test_helper'

class Defekt::TestTest < Minitest::Test
  def setup
    @pass = Defekt::Test.new(FakeTest.instance_method(:test_passes))
    @fail = Defekt::Test.new(FakeTest.instance_method(:test_fails))
    @error = Defekt::Test.new(FakeTest.instance_method(:test_errors))
  end

  def test_initialize
    assert_instance_of Defekt::Test, @pass
  end

  def test_methot
    assert_instance_of UnboundMethod, @pass.methot
  end

  def test_error
    assert_nil @pass.error

    @pass.instance_variable_set(:@error, StandardError.new)
    assert_equal StandardError.new, @pass.error
  end

  def test_instance
    assert_instance_of FakeTest, @pass.instance
  end

  def test_run
    assert_equal '.', @pass.run
    assert_equal 'f', @fail.run
    assert_equal 'e', @error.run
  end

  def test_before_after
    @pass.run # with original before and after
    assert_equal 'after', @pass.instance.instance_variable_get(:@callback)

    stubbed_fail_instance = FakeTest.new
    stub(stubbed_fail_instance, :after, nil)
    stub(@fail, :instance, stubbed_fail_instance)
    @fail.run # with original before and stubbed after
    assert_equal 'before', @fail.instance.instance_variable_get(:@callback)

    stubbed_error_instance = FakeTest.new
    stub(stubbed_error_instance, :before, nil)
    stub(stubbed_error_instance, :after, nil)
    stub(@error, :instance, stubbed_error_instance)
    @error.run # with stubbed before and after
    assert_nil @error.instance.instance_variable_get(:@callback)
  end

  def test_status
    assert_equal 'did not run', @pass.status

    stub(@pass, :passed?, true)
    assert_equal 'passed', @pass.status

    stub(@fail, :failed?, true)
    assert_equal 'failed', @fail.status

    stub(@error, :errored?, true)
    assert_equal 'errored', @error.status
  end

  def test_summary
    stub(@fail, :ran?, true)
    stub(@fail, :error, Defekt::Errors::BaseError.new)
    assert_instance_of String, @fail.summary
    assert_includes @fail.summary, 'FakeTest#test_fails'
    assert_includes @fail.summary, 'test/support/fake_test.rb:13 failed'
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

    stub(@fail, :ran?, true)
    stub(@fail, :error, Defekt::Errors::BaseError.new)
    refute @fail.passed?

    stub(@error, :ran?, true)
    stub(@error, :error, StandardError.new)
    refute @error.passed?
  end

  def test_failed?
    refute @fail.failed?

    stub(@fail, :ran?, true)
    stub(@fail, :error, Defekt::Errors::BaseError.new)
    assert @fail.failed?

    stub(@pass, :ran?, true)
    refute @pass.failed?

    stub(@error, :ran?, true)
    stub(@error, :error, StandardError.new)
    refute @error.failed?
  end

  def test_errored?
    refute @error.errored?

    stub(@error, :ran?, true)
    stub(@error, :error, StandardError.new)
    assert @error.errored?

    stub(@pass, :ran?, true)
    refute @pass.errored?

    stub(@fail, :ran?, true)
    stub(@fail, :error, Defekt::Errors::BaseError.new)
    refute @fail.errored?
  end

  def test_broken?
    refute @pass.broken?
    refute @fail.broken?
    refute @error.broken?

    stub(@pass, :ran?, true)
    refute @pass.broken?

    stub(@fail, :ran?, true)
    stub(@fail, :error, Defekt::Errors::BaseError.new)
    assert @fail.broken?

    stub(@error, :ran?, true)
    stub(@error, :error, StandardError.new)
    assert @error.broken?
  end
end
