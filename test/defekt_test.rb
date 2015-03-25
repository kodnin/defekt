require_relative 'test_helper'

class DefektTest < Minitest::Test
  def test_run
    assert_respond_to Defekt, :run
  end
end
