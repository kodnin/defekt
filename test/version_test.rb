require_relative 'test_helper'

class Defekt::VersionTest < Minitest::Test
  def test_version
    assert_equal '0.0.4', Defekt::VERSION
  end
end
