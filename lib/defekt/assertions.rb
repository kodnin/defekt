module Defekt
  module Assertions
    def true!(value)
      unless value
        raise Errors::TrueError, message(value, 'is not', true)
      end
    end

    def equal_to!(expected, actual)
      unless actual == expected
        raise Errors::EqualToError, message(actual, 'is not equal to', expected)
      end
    end

    def identical_to!(expected, actual)
      unless actual.equal?(expected)
        raise Errors::IdenticalToError, message(actual, 'is not identical to', expected)
      end
    end

    def included_in!(collection, member)
      unless collection.include?(member)
        raise Errors::IncludedInError, message(member, 'is not included in', collection)
      end
    end

    def instance_of!(klass, instance)
      unless instance.instance_of?(klass)
        raise Errors::InstanceOfError, message(instance, 'is not an instance of', klass)
      end
    end

    def kind_of!(klass, instance)
      unless instance.kind_of?(klass)
        raise Errors::KindOfError, message(instance, 'is not a kind of', klass)
      end
    end

    private

    def message(object1, text, object2)
      "~#{object1}~ #{text} #{object2}"
    end
  end
end
