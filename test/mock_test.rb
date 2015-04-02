require_relative 'test_helper'

class Defekt::MockTest < Minitest::Test
  def setup
    @mock = Defekt::Mock.new
  end

  def test_initialize
    assert_instance_of Defekt::Mock, @mock
  end

  def test_expect
    refute_respond_to @mock, :foo
    assert_equal @mock, @mock.expect(:foo, 'bar')
    assert_respond_to @mock, :foo
    assert_equal 'bar', @mock.foo
    @mock.expect(:baz, nil, ['quux'])
    assert_equal [[:foo, []], [:baz, ['quux']]], @mock.instance_variable_get(:@expected_calls)
    assert_equal [[:foo, []]], @mock.instance_variable_get(:@actual_calls)
  end

  def test_verify
    expected = [[:foo, ['bar', 'baz']]]
    @mock.stub(:expected_calls, expected.shuffle) do
      @mock.stub(:actual_calls, expected.shuffle) do
        assert @mock.verify
      end
      @mock.stub(:actual_calls, []) do
        refute @mock.verify
      end
      @mock.stub(:actual_calls, [[:foo, []]]) do
        refute @mock.verify
      end
      @mock.stub(:actual_calls, [[:foo, ['baz', 'bar']]]) do
        refute @mock.verify
      end
    end
  end
end
