$LOAD_PATH.unshift(File.expand_path('../../../lib', __FILE__))

require 'defekt'

class Hacker
  def identity(person)
    person.name
  end
end

class HackerTest < Defekt::Base
  def before
    @hacker = Hacker.new
  end

  def test_mock
    mock = Defekt::Mock.new
    mock.expect(:name, 'kodnin')
    equal_to! 'kodnin', @hacker.identity(mock)
    verify! mock
  end

  def test_stub
    not_respond_to! @hacker, :password
    @hacker.stub(:password, 'nindok') do
      respond_to! @hacker, :password
      equal_to! 'nindok', @hacker.password
    end
    not_respond_to! @hacker, :password
  end
end

Defekt.run
