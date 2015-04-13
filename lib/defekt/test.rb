module Defekt
  class Test
    attr_reader :methot, :error

    def initialize(methot)
      @methot = methot
    end

    def instance
      @instance ||= methot.owner.new
    end

    def run
      @ran = true

      begin
        instance.before if instance.respond_to?(:before)
        methot.bind(instance).call
        '.'
      rescue => e
        @error = e
        status.chars.first
      ensure
        instance.after if instance.respond_to?(:after)
      end
    end

    def summary
      "#{methot.owner}##{methot.name} at #{methot.source_location.join(':')} #{status}"
    end

    def ran?
      !!@ran
    end

    def passed?
      ran? && error.nil?
    end

    def failed?
      ran? && !passed? && error.kind_of?(Errors::BaseError)
    end

    def errored?
      ran? && !failed? && error.kind_of?(Exception)
    end

    def broken?
      failed? || errored?
    end

    def status
      case
      when passed?
        'passed'
      when failed?
        'failed'
      when errored?
        'errored'
      else
        'did not run'
      end
    end
  end
end
