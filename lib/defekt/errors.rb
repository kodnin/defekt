module Defekt
  module Errors
    class BaseError < StandardError
      def message
        "#{super} (#{self.class.name})"
      end

      def self.name
        super.sub('Defekt::Errors::', '')
      end
    end
  end
end
