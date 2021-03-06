module Defekt
  class Base
    include Assertions

    def self.before(&block)
      define_method(:before, &block)
    end

    def self.after(&block)
      define_method(:after, &block)
    end

    def self.test(name, &block)
      safe_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
      define_method(safe_name, &block)
    end

    def self.children
      @children ||= []
    end

    def self.descendants
      children + children.flat_map(&:descendants)
    end

    private

    def self.inherited(klass)
      children.push(klass)
    end
  end
end
