module Defekt
  class Collection
    def initialize(klass)
      @klass = klass
    end

    def all
      @all ||= @klass.descendants.map do |klass|
        klass.instance_methods.grep(/^test_/).map do |methot|
          BaseObject.new(klass.instance_method(methot))
        end
      end.flatten
    end

    def passed
      @passed ||= all.select(&:passed?)
    end

    def failed
      @failed ||= all.select(&:failed?)
    end

    def errored
      @errored ||= all.select(&:errored?)
    end

    def defekt
      @defekt ||= all.select(&:defekt?)
    end
  end
end
