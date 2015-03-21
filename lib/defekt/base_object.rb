module Defekt
  class BaseObject
    attr_reader :methot, :exception

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
        @exception = e
        status.chars.first
      ensure
        object.after
      end
    end

    def report
      "#{klass}##{methot.name} at #{location} #{status}"
    end

    def ran?
      !!@ran
    end

    def passed?
      ran? && exception.nil?
    end

    def failed?
      ran? && !passed? && exception.kind_of?(Errors::BaseError)
    end

    def errored?
      ran? && !failed? && exception.kind_of?(Exception)
    end

    private

    def status
      case
      when passed?
        'passed'
      when failed?
        'failed'
      when errored?
        'errored'
      else
        'not run'
      end
    end
  end
end
