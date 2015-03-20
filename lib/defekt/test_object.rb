module Defekt
  class TestObject
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

    def ran?
      !!@ran
    end

    def passed?
      ran? && exception.nil?
    end

    def failed?
      ran? && !passed? && exception.kind_of?(Defekt::Exceptions::TestError)
    end

    def errored?
      ran? && !failed? && exception.kind_of?(Exception)
    end

    def report
      [summary, exception.message].join("\n  ")
    end

    private

    def status
      failed? ? 'failed' : 'errored'
    end

    def summary
      "#{klass}##{methot} at #{location} #{status}"
    end
  end
end
