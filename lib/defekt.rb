require 'defekt/assertions'
require 'defekt/base'
require 'defekt/collection'
require 'defekt/errors'
require 'defekt/object'
require 'defekt/runner'
require 'defekt/test'
require 'defekt/version'

module Defekt
  def self.run(klass=Base)
    Runner.new(Collection.new(klass)).run.report
  end
end
