require_relative 'test_helper'

class VersionTest < Minitest::Test
  def test_version
    assert_equal '0.0.2', Defekt::VERSION
  end
end
