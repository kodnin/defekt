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

Inherit your test classes from `Defekt::Base` and define your tests prefixed with `test_`. You can define `before` and `after` methods, which are invoked around each test.

```ruby
require 'defekt'

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

  def test_age
    not_respond_to! @person, :age
    @person.stub(:age, 'unknown') do
      respond_to! @person, :age
      equal_to! 'unknown', @person.age
    end
  end
end

Defekt.run
```

## Assertions

Both positive and negative assertions are available.

Positive | Negative
--- | ---
true! | not_true!
nil! | not_nil!
equal_to! | not_equal_to!
identical_to! | not_identical_to!
included_in! | not_included_in!
instance_of! | not_instance_of!
kind_of! | not_kind_of!
respond_to! | not_respond_to!

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it (https://github.com/kodnin/defekt/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
