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
    stubbed_fail_instance.stub :after, nil do
      @fail.stub :instance, stubbed_fail_instance do
        @fail.run # with original before and stubbed after
        assert_equal 'before', @fail.instance.instance_variable_get(:@callback)
      end
    end

    stubbed_error_instance = FakeTest.new
    stubbed_error_instance.stub :before, nil do
      stubbed_error_instance.stub :after, nil do
        @error.stub :instance, stubbed_error_instance do
          @error.run # with stubbed before and after
          assert_nil @error.instance.instance_variable_get(:@callback)
        end
      end
    end
  end

  def test_summary
    @fail.stub :ran?, true do
      @fail.stub :error, Defekt::Errors::BaseError.new do
        assert_instance_of String, @fail.summary
        assert_includes @fail.summary, 'FakeTest#test_fails'
        assert_includes @fail.summary, 'test/support/fake_test.rb:13 failed'
      end
    end
  end

  def test_ran?
    refute @pass.ran?

    @pass.instance_variable_set(:@ran, true)
    assert @pass.ran?
  end

  def test_passed?
    refute @pass.passed?

    @pass.stub :ran?, true do
      assert @pass.passed?
    end

    @fail.stub :ran?, true do
      @fail.stub :error, Defekt::Errors::BaseError.new do
        refute @fail.passed?
      end
    end

    @error.stub :ran?, true do
      @error.stub :error, StandardError.new do
        refute @error.passed?
      end
    end
  end

  def test_failed?
    refute @fail.failed?

    @fail.stub :ran?, true do
      @fail.stub :error, Defekt::Errors::BaseError.new do
        assert @fail.failed?
      end
    end

    @pass.stub :ran?, true do
      refute @pass.failed?
    end

    @error.stub :ran?, true do
      @error.stub :error, StandardError.new do
        refute @error.failed?
      end
    end
  end

  def test_errored?
    refute @error.errored?

    @error.stub :ran?, true do
      @error.stub :error, StandardError.new do
        assert @error.errored?
      end
    end

    @pass.stub :ran?, true do
      refute @pass.errored?
    end

    @fail.stub :ran?, true do
      @fail.stub :error, Defekt::Errors::BaseError.new do
        refute @fail.errored?
      end
    end
  end

  def test_broken?
    refute @pass.broken?
    refute @fail.broken?
    refute @error.broken?

    @pass.stub :ran?, true do
      refute @pass.broken?
    end

    @fail.stub :ran?, true do
      @fail.stub :error, Defekt::Errors::BaseError.new do
        assert @fail.broken?
      end
    end

    @error.stub :ran?, true do
      @error.stub :error, StandardError.new do
        assert @error.broken?
      end
    end
  end

  def test_status
    assert_equal 'did not run', @pass.status

    @pass.stub :passed?, true do
      assert_equal 'passed', @pass.status
    end

    @fail.stub :failed?, true do
      assert_equal 'failed', @fail.status
    end

    @error.stub :errored?, true do
      assert_equal 'errored', @error.status
    end
  end
end
