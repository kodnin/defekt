module Defekt
  class Base
    include Assertions

    [:before, :after].each { |methot| define_method(methot) {} }

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
