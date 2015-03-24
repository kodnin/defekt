require_relative 'test_helper'

class Defekt::VersionTest < Minitest::Test
  def test_version
    assert_equal '0.0.3', Defekt::VERSION
  end
end
