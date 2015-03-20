module Defekt
  class TestObject
    attr_reader :methot, :exception

    def initialize(methot)
      @methot = methot
    end

    def klass
      methot.owner
    end

    def location
      methot.source_location.join(':')
    end

    def run
      begin
        @ran = true
        methot.bind(klass.new).call
        '.'
      rescue => e
        @exception = e
        failed? ? 'f' : 'e'
      end
    end

    def ran?
      !!@ran
    end

    def passed?
      ran? && exception.nil?
    end

    def failed?
      !passed? && exception.kind_of?(Defekt::Exceptions::TestError)
    end

    def errored?
      !failed? && exception
    end

    def report
      "#{klass}##{methot} at #{location} #{failed? ? 'failed' : 'errored'}" +
        "\n" + "  #{exception.message} (#{exception.class.name})"
    end
  end
end
