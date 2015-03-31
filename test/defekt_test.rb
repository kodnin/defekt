require_relative 'test_helper'

class DefektTest < Minitest::Test
  def test_run
    assert_respond_to Defekt, :run
    mock = MiniTest::Mock.new
    mock.expect(:run, mock)
    mock.expect(:report, mock)
    load File.expand_path('../../lib/defekt/object.rb', __FILE__) # FIXME
    Defekt::Runner.stub(:new, mock) { Defekt.run }
    load 'minitest/mock.rb' # FIXME
    assert mock.verify
  end
end
