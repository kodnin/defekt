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

  def test_true_error
    assert_kind_of Defekt::Errors::BaseError, Defekt::Errors::TrueError.new
  end

  def test_equal_to_error
    assert_kind_of Defekt::Errors::BaseError, Defekt::Errors::EqualToError.new
  end

  def test_included_in_error
    assert_kind_of Defekt::Errors::BaseError, Defekt::Errors::IncludedInError.new
  end

  def test_instance_of_error
    assert_kind_of Defekt::Errors::BaseError, Defekt::Errors::InstanceOfError.new
  end
end
