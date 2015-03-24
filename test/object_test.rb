require_relative 'test_helper'
load File.expand_path('../../lib/defekt/object.rb', __FILE__) # reload Object

class ObjectTest < Minitest::Test
  def test_stub
    object = Object.new

    e = assert_raises(ArgumentError) { object.stub(:object_id) }
    assert_equal 'block is required', e.message

    refute object.nil?
    object.stub(:nil?) { 1 < 2 }
    assert object.nil?
    assert_raises(ArgumentError) { object.nil?(1, 2, 3) }

    refute object.instance_of?(BasicObject)
    object.stub(:instance_of?) { |klass| 1 < 2 }
    assert object.instance_of?(BasicObject)
    assert_raises(ArgumentError) { object.instance_of? }
  end
end
