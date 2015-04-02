module Defekt
  class Mock
    def expect(methot, value, arguments=[])
      expected_calls.push([methot, arguments])

      define_singleton_method(methot) do |*args|
        actual_calls.push([methot, args])
        value
      end

      self
    end

    def verify
      expected_calls.uniq.sort == actual_calls.uniq.sort
    end

    private

    def expected_calls
      @expected_calls ||= []
    end

    def actual_calls
      @actual_calls ||= []
    end
  end
end
