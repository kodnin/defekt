require_relative 'test_helper'

class Defekt::RunnerTest < Minitest::Test
  def setup
    collection = Defekt::Collection.new(FakeTest)
    @runner = Defekt::Runner.new(collection)
    FakeTest.stub :descendants, [FakeTest] do
      @runner.collection.all # memoize collection with stubbed descendants
    end
  end

  def test_initialize
    assert_instance_of Defekt::Runner, @runner
  end

  def test_collection
    assert_instance_of Defekt::Collection, @runner.collection
  end

  def test_benchmark
    @runner.stub :print, nil do
      @runner.run
    end
    assert_instance_of Benchmark::Tms, @runner.benchmark
  end

  def test_run
    assert_output(/^[.fe]{3}$/) { @runner.run }
    assert @runner.collection.all.map(&:ran?).all?
    @runner.stub :print, nil do
      assert_equal @runner, @runner.run
    end
  end

  def test_report
    assert_output { @runner.run }
    @runner.stub :print, nil do
      @runner.stub :puts, nil do
        assert_equal @runner, @runner.run.report
      end
    end
  end

  def test_statistics
    @runner.stub :print, nil do
      @runner.run
    end
    format = /^\d+ passed, \d+ failed, \d+ errored of \d+ tests \(in \d+\.\d+ seconds\)$/
    assert_match format, @runner.statistics
  end
end
