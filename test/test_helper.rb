$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'defekt'
require 'minitest/autorun'

class Minitest::Test
  def stub(object, methot, value)
    object.instance_eval { define_singleton_method(methot) { value } }
  end
end
