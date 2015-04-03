$LOAD_PATH.unshift(File.expand_path('../../../lib', __FILE__))

require 'defekt/autorun'

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class PersonTest < Defekt::Base
  def before
    @person = Person.new('kodnin')
  end

  def test_initialize
    instance_of! Person, @person
  end

  def test_name
    equal_to! 'kodnin', @person.name
  end
end
