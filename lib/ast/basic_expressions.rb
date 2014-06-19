# collection of the simple ones, int and strings and such

module Ast

  class IntegerExpression < Expression
    attr_reader :value
    def initialize val
      @value = val
    end
    def inspect
      self.class.name + ".new(" + value.to_s+ ")"
    end
    def to_s
      value.to_s
    end
    def attributes
      [:value]
    end
  end

  class NameExpression < Expression
    attr_reader  :name
    def initialize name
      @name = name.to_sym
    end
    def inspect
      "#{self.class.name}.new(#{name.inspect})"
    end
    def to_s
      name.to_s
    end
    def attributes
      [:name]
    end
  end

  class ModuleName < NameExpression
  end

  class StringExpression < Expression
    attr_reader  :string
    def initialize str
      @string = str
    end
    def inspect
      self.class.name + '.new("' + string + '")'
    end
    def to_s
      '"' + string.to_s + '"'
    end
    def attributes
      [:string]
    end
  end

end