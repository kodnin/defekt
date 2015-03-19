require_relative 'test_helper'

class TestDefekt < Minitest::Test
  def test_defekt_version
    assert_equal '0.0.1', Defekt::VERSION
  end
end
