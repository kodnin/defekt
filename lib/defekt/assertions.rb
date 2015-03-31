module Defekt
  module Assertions
    def true!(value)
      unless value
        raise Errors::TrueError, message(value, 'is not', true)
      end
    end

    def not_true!(value)
      if value
        raise Errors::NotTrueError, message(value, 'is', true)
      end
    end

    def nil!(value)
      unless value.nil?
        raise Errors::NilError, message(value, 'is not', nil)
      end
    end

    def not_nil!(value)
      if value.nil?
        raise Errors::NotNilError, message(value, 'is', nil)
      end
    end

    def equal_to!(expected, actual)
      unless actual == expected
        raise Errors::EqualToError, message(actual, 'is not equal to', expected)
      end
    end

    def not_equal_to!(expected, actual)
      if actual == expected
        raise Errors::NotEqualToError, message(actual, 'is equal to', expected)
      end
    end

    def identical_to!(expected, actual)
      unless actual.equal?(expected)
        raise Errors::IdenticalToError, message(actual, 'is not identical to', expected)
      end
    end

    def not_identical_to!(expected, actual)
      if actual.equal?(expected)
        raise Errors::NotIdenticalToError, message(actual, 'is identical to', expected)
      end
    end

    def included_in!(collection, member)
      unless collection.include?(member)
        raise Errors::IncludedInError, message(member, 'is not included in', collection)
      end
    end

    def not_included_in!(collection, member)
      if collection.include?(member)
        raise Errors::NotIncludedInError, message(member, 'is included in', collection)
      end
    end

    def instance_of!(klass, instance)
      unless instance.instance_of?(klass)
        raise Errors::InstanceOfError, message(instance, 'is not an instance of', klass)
      end
    end

    def not_instance_of!(klass, instance)
      if instance.instance_of?(klass)
        raise Errors::NotInstanceOfError, message(instance, 'is an instance of', klass)
      end
    end

    def kind_of!(klass, instance)
      unless instance.kind_of?(klass)
        raise Errors::KindOfError, message(instance, 'is not a kind of', klass)
      end
    end

    def not_kind_of!(klass, instance)
      if instance.kind_of?(klass)
        raise Errors::NotKindOfError, message(instance, 'is a kind of', klass)
      end
    end

    def respond_to!(object, methot)
      unless object.respond_to?(methot)
        raise Errors::RespondToError, message(object, 'does not respond to', methot)
      end
    end

    def not_respond_to!(object, methot)
      if object.respond_to?(methot)
        raise Errors::NotRespondToError, message(object, 'does respond to', methot)
      end
    end

    private

    def message(object1, text, object2)
      "#{object1.inspect} #{text} #{object2.inspect}"
    end
  end
end
