require_relative 'test_helper'

class Defekt::ErrorsTest < Minitest::Test
  def setup
    @error = Defekt::Errors::BaseError.new('Nein!')
  end

  def test_module
    assert_instance_of Module, Defekt::Errors
  end

  def test_initialize
    assert_kind_of StandardError, @error
    assert_instance_of Defekt::Errors::BaseError, @error
  end

  def test_message
    assert_equal 'Nein! (BaseError)', @error.message
  end

  def test_name
    assert_equal 'BaseError', @error.class.name
  end

  def test_const_missing
    non_existing_error = Defekt::Errors::NonExistingError.new
    assert_kind_of Defekt::Errors::BaseError, non_existing_error
    assert_instance_of Defekt::Errors::NonExistingError, non_existing_error
  end
end
