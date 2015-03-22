module Defekt
  class Base
    include Assertions

    def before
    end

    def after
    end

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
