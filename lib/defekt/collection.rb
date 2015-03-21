module Defekt
  class Collection
    def initialize(klass)
      @klass = klass
    end

    def all
      @klass.descendants.map do |klass|
        klass.instance_methods.grep(/^test_/).map do |methot|
          Defekt::TestObject.new(klass.instance_method(methot))
        end
      end.flatten
    end
  end
end
