module Defekt
  class TestClass
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
