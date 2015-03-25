module Defekt
  class Base
    include Assertions

    [:before, :after].each { |methot| define_method(methot) {} }

    def self.children
      @children ||= []
    end

    def self.descendants
      children + children.map(&:descendants).flatten
    end

    private

    def self.inherited(klass)
      children.push(klass)
    end
  end
end
