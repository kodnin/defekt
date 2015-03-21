module Defekt
  module Assertions
    def true!(boolean)
      unless boolean
        raise Errors::TrueError, "|#{boolean}| is not |true|"
      end
    end

    def equal_to!(expected, actual)
      unless expected == actual
        raise Errors::EqualToError, "|#{actual}| is not equal to |#{expected}|"
      end
    end

    def included_in!(collection, member)
      unless collection.include?(member)
        raise Errors::IncludedInError, "|#{member}| is not included in |#{collection}|"
      end
    end

    def instance_of!(klass, instance)
      unless instance.instance_of?(klass)
        raise Errors::InstanceOfError, "|#{instance}| is not an instance of |#{klass}|"
      end
    end
  end
end
