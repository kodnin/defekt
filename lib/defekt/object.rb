class Object
  def stub(methot, value)
    singleton_methot_exists = respond_to?(methot) && singleton_methods.include?(methot)

    if singleton_methot_exists
      original = "__original_#{methot}__"
      singleton_class.class_eval { alias_method(original, methot) }
    end

    define_singleton_method(methot) { |*arguments| value }

    yield

    if singleton_methot_exists
      singleton_class.class_eval do
        alias_method(methot, original)
        remove_method(original)
      end
    else
      singleton_class.class_eval { remove_method(methot) }
    end
  end
end
