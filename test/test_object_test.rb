require_relative 'test_helper'

class Defekt::TestObjectTest < Minitest::Test
  class Fake
    def passes; end
    def fails; raise Defekt::Exceptions::TestError; end
    def errors; raise StandardError; end
  end

  def setup
    @pass = Defekt::TestObject.new(Fake.instance_method(:passes))
    @fail = Defekt::TestObject.new(Fake.instance_method(:fails))
    @error = Defekt::TestObject.new(Fake.instance_method(:errors))
  end

  def test_initialize
    assert_instance_of Defekt::TestObject, @pass
  end

  def test_klass
    assert_equal Fake, @pass.klass
  end

  def test_methot
    assert_instance_of UnboundMethod, @pass.methot
  end

  def test_location
    assert_instance_of String, @pass.location
    assert_includes @pass.location, 'test/test_object_test.rb:5'
  end

  def test_exception
    assert_nil @pass.exception

    @pass.instance_variable_set(:@exception, StandardError.new)
    assert_equal StandardError.new, @pass.exception
  end

  def test_run
    assert_equal '.', @pass.run
    assert_equal 'f', @fail.run
    assert_equal 'e', @error.run
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
    assert_includes @fail.report, 'Defekt::TestObjectTest::Fake#fails'
    assert_includes @fail.report, 'test/test_object_test.rb:6 failed'
    assert_includes @fail.report, 'Defekt::Exceptions::TestError (TestError)'
  end
end
