module Defekt
  module Exceptions
    class TestError < StandardError
      def self.name
        super.sub('Defekt::Exceptions::', '')
      end
    end
  end
end
