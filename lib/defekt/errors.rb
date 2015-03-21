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

    TrueError = Class.new(BaseError)
    EqualToError = Class.new(BaseError)
    IncludedInError = Class.new(BaseError)
    InstanceOfError = Class.new(BaseError)
  end
end
