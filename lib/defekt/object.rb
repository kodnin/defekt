class Object
  def stub(methot, &block)
    raise ArgumentError, 'block is required' unless block
    define_singleton_method(methot, block)
  end
end
