require 'benchmark'

module Defekt
  class Runner
    attr_reader :collection, :benchmark

    def initialize(collection)
      @collection = collection
    end

    def run
      @benchmark = Benchmark.measure do
        collection.all.shuffle.each { |test| print test.run }
      end
      self
    end

    def report
      puts nil, nil
      puts report_broken, nil if collection.broken.any?
      puts statistics
      self
    end

    def statistics
      "#{collection.passed.length} passed, #{collection.failed.length} failed" +
        ", #{collection.errored.length} errored of #{collection.all.length} " +
        "tests (in #{benchmark.real.round(3)} seconds)"
    end

    private

    def report_broken
      collection.broken.flat_map do |test|
        [test.summary, "  #{test.error.message}"]
      end.join("\n")
    end
  end
end
