require_relative 'test_helper'

class Defekt::ExceptionsTest < Minitest::Test
  def setup
    @test_error = Defekt::Exceptions::TestError.new('Nein!')
  end

  def test_module
    assert_instance_of Module, Defekt::Exceptions
  end

  def test_initialize
    assert_kind_of StandardError, @test_error
    assert_instance_of Defekt::Exceptions::TestError, @test_error
  end

  def test_message
    assert_equal 'Nein! (TestError)', @test_error.message
  end

  def test_name
    assert_equal 'TestError', @test_error.class.name
  end
end
