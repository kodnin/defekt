module Defekt
  module Exceptions
    class TestError < StandardError
      def message
        "#{super} (#{self.class.name})"
      end

      def self.name
        super.sub('Defekt::Exceptions::', '')
      end
    end
  end
end
