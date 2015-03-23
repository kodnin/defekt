$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'defekt'
require 'minitest/autorun'
require_relative 'support/fake_test'

class Minitest::Test
  def stub(object, methot, value)
    object.instance_eval { define_singleton_method(methot) { |*args| value } }
  end
end
