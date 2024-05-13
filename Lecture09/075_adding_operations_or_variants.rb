# Programming Languages
# Lecture 09: Adding Operations or Variants

# Note: If Exp and Value are empty classes, we do not need them in a
# dynamically typed language, but they help show the structure and they
# can be useful places for code that applies to multiple subclasses.

class Exp
    # could put default implementations or helper methods here
  
end
  
class Value < Exp
    # this is overkill here, but is useful if you have multiple kinds of
    # /values/ in your language that can share methods that do not make sense 
    # for non-value expressions
end
  
class Int < Value
    attr_reader :i
    
    def initialize i
        @i = i
    end

    def eval
        self
    end
    
    def to_s
        @i.to_s
    end

    def has_zero?
        i == 0
    end

    def no_neg_constants
        if i < 0
            Negate.new(Int.new(-i))
        else
            self
        end
    end
end
  
class Negate < Exp
    attr_reader :e
    
    def initialize e
        @e = e
    end

    def eval
        Int.new(-e.eval.i) # error if e.eval has no i method
    end

    def to_s
        "-(" + e.to_s + ")"
    end

    def has_zero?
        e.has_zero?
    end

    def no_neg_constants
        Negate.new(e.no_neg_constants)
    end
end
  
class Add < Exp
    attr_reader :e1, :e2

    def initialize(e1, e2)
        @e1 = e1
        @e2 = e2
    end

    def eval 
        Int.new(e1.eval.i + e2.eval.i) # error if e1.eval or e2.eval has no i method
    end

    def to_s
        "(" + e1.to_s + " + " + e2.to_s + ")"
    end

    def has_zero?
        e1.has_zero? || e2.has_zero?
    end

    def no_neg_constants
        Add.new(e1.no_neg_constants, e2.no_neg_constants)
    end
end

class Mult < Exp
    attr_reader :e1, :e2

    def initialize(e1, e2)
        @e1 = e1
        @e2 = e2
    end

    def eval 
        Int.new(e1.eval.i * e2.eval.i)
    end

    def to_s
        "(" + e1.to_s + " * " + e2.to_s + ")"
    end

    def has_zero?
        e1.has_zero? || e2.has_zero?
    end

    def no_neg_constants
        Mult.new(e1.no_neg_constants, e2.no_neg_constants)
    end
end

# 5 + 10 * (-3)
exp = Add.new(Int.new(5), Mult.new(Int.new(10), Negate.new(Int.new(3))))

puts "Does exp have zero? " + exp.has_zero?.to_s
puts exp.to_s + " = " + exp.eval.to_s

# 5 + 10 * (-3)
exp2 = Add.new(Int.new(5), Mult.new(Int.new(10), Int.new(-3))).no_neg_constants
puts "Does exp2 have zero? " + exp2.has_zero?.to_s
puts exp2.to_s + " = " + exp2.eval.to_s