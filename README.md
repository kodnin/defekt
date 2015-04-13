[![Gem Version](https://badge.fury.io/rb/defekt.svg)](http://badge.fury.io/rb/defekt)
[![Build Status](https://travis-ci.org/kodnin/defekt.svg?branch=master)](https://travis-ci.org/kodnin/defekt)

# Defekt

A micro testing framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'defekt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install defekt

## Usage

Inherit your test classes from `Defekt::Base` and use the `test` method to define your tests. You can use the `before` and `after` methods to specify context blocks, which are yielded around each test. By requiring `defekt/autorun` your tests are automatically run.

```ruby
require 'defekt/autorun'

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class PersonTest < Defekt::Base
  before { @person = Person.new('kodnin') }

  test '#initialize' do
    instance_of! Person, @person
  end

  test '#name' do
    equal_to! 'kodnin', @person.name
  end
end
```

## Assertions

Both positive and negative assertions are available.

Positive | Negative | Argument(s)
--- | --- | ---
true! | not_true! | value
nil! | not_nil! | value
equal_to! | not_equal_to! | expected, actual
identical_to! | not_identical_to! | expected, actual
instance_of! | not_instance_of! | class, instance
kind_of! | not_kind_of! | class, instance
respond_to! | not_respond_to! | object, method
included_in! | not_included_in! | collection, member

You can add your own assertions by opening up the `Defekt::Assertions` module.

```ruby
module Defekt
  module Assertions
    def awesome!(value)
      unless value == 'awesome'
        raise Errors::AwesomeError, "#{value.inspect} is not awesome"
      end
    end
  end
end
```

## Mocking and stubbing

Basic mocking and stubbing functionality is supported.

```ruby
require 'defekt/autorun'

class Hacker
  def identity(person)
    person.name
  end
end

class HackerTest < Defekt::Base
  before { @hacker = Hacker.new }

  test 'mock' do
    mock = Defekt::Mock.new
    mock.expect(:name, 'kodnin')
    equal_to! 'kodnin', @hacker.identity(mock)
    verify! mock
  end

  test 'stub' do
    not_respond_to! @hacker, :password
    @hacker.stub(:password, 'nindok') do
      respond_to! @hacker, :password
      equal_to! 'nindok', @hacker.password
    end
    not_respond_to! @hacker, :password
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it (https://github.com/kodnin/defekt/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
