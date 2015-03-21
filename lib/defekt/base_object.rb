module Defekt
  class BaseObject
    attr_reader :methot, :error

    def initialize(methot)
      @methot = methot
    end

    def klass
      methot.owner
    end

    def object
      @object ||= klass.new
    end

    def location
      methot.source_location.join(':')
    end

    def run
      @ran = true

      begin
        object.before
        methot.bind(object).call
        '.'
      rescue => e
        @error = e
        status.chars.first
      ensure
        object.after
      end
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

    def report
      "#{klass}##{methot.name} at #{location} #{status}"
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

    def defekt?
      failed? || errored?
    end
  end
end
