class FakeTest
  attr_reader :feedback

  def before
    @feedback = 'before'
  end

  def after
    @feedback = 'after'
  end

  def test_passes
  end

  def test_fails
    raise Defekt::Errors::BaseError
  end

  def test_errors
    raise StandardError
  end
end
