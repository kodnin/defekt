class FakeTest
  def before
    @callback = 'before'
  end

  def after
    @callback = 'after'
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
