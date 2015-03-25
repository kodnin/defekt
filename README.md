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

Inherit test classes from ```Defekt::Base``` and define tests prefixed with ```test_```. ```before``` and ```after``` methods are optional, which will be invoked around a test.

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
    @person.stub(:age) { 'unknown' }
    equal_to! 'unknown', @person.age
  end
end

Defekt.run
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
