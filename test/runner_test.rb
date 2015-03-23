require_relative 'test_helper'

class Defekt::RunnerTest < Minitest::Test
  def setup
    stub(FakeTest, :descendants, [FakeTest])
    collection = Defekt::Collection.new(FakeTest)
    @runner = Defekt::Runner.new(collection)
  end

  def test_initialize
    assert_instance_of Defekt::Runner, @runner
  end

  def test_collection
    assert_instance_of Defekt::Collection, @runner.collection
  end

  def test_benchmark
    stub(@runner, :print, nil)
    @runner.run
    assert_instance_of Benchmark::Tms, @runner.benchmark
  end

  def test_run
    assert_output(/^[.fe]{3}$/) { @runner.run }
    assert @runner.collection.all.map(&:ran?).all?
    stub(@runner, :print, nil)
    assert_equal @runner, @runner.run
  end

  def test_statistics
    stub(@runner, :print, nil)
    @runner.run
    regex = /^\d+ passed, \d+ failed, \d+ errored of \d+ tests \(in \d+\.\d+ seconds\)$/
    assert_match regex, @runner.statistics
  end

  def test_report
    assert_output { @runner.run }
    stub(@runner, :print, nil)
    stub(@runner, :puts, nil)
    assert_equal @runner, @runner.run.report
  end
end
