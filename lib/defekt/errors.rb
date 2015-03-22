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

    private

    def self.const_missing(klass)
      const_set(klass, Class.new(BaseError))
    end
  end
end
