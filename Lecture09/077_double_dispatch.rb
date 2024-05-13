# Programming Languages
# Lecture 09: Binary Methods with OOP: Double Dispatch

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

    # double-dispatch for adding values
    def add_values v # first dispatch
        v.add_int self
    end

    def add_int v # second dispatch: other is Int
        Int.new(v.i + i)
    end

    def add_string v # second dispatch: other is MyString (notice order flipped)
        MyString.new(v.s + i.to_s)
    end

    def add_rational v # second dispatch: other is MyRational
        MyRational.new(v.i + v.j * i, v.j)
    end
    
    def mult_values v
        v.mult_int self
    end

    def mult_int v
        Int.new(v.i * i)
    end

    def mult_string v
        raise "Cannot multiply string by int"
    end

    def mult_rational v
        MyRational.new(v.i * i, v.j)
    end
end

# new value classes -- avoiding name-conflict with built-in String, Rational
class MyString < Value
    attr_reader :s

    def initialize s
        @s = s
    end

    def eval
        self
    end

    def to_s
        s
    end

    def has_zero?
        false
    end

    def no_neg_constants
        self
    end
  
    # double-dispatch for adding values
    def add_values v # first dispatch
        v.add_string self
    end

    def add_int v # second dispatch: other is Int (notice order is flipped)
        MyString.new(v.i.to_s + s)
    end

    def add_string v # second dispatch: other is MyString (notice order flipped)
        MyString.new(v.s + s)
    end

    def addRational v # second dispatch: other is MyRational (notice order flipped)
        MyString.new(v.i.to_s + "/" + v.j.to_s + s)
    end

    def mult_values v
        v.mult_string self
    end

    def mult_int v
        raise "Cannot multiply string by int"
    end

    def mult_string v
        raise "Cannot multiply string by string"
    end

    def mult_rational v
        raise "Cannot multiply string by rational"
    end
end

class MyRational < Value
    attr_reader :i, :j

    def initialize(i,j)
        @i = i
        @j = j
    end

    def eval
        self
    end

    def to_s
        i.to_s + "/" + j.to_s
    end

    def has_zero?
        i==0
    end

    def no_neg_constants
        if i < 0 && j < 0
            MyRational.new(-i, -j)
        elsif j < 0
            Negate.new(MyRational.new(i, -j))
        elsif i < 0
            Negate.new(MyRational.new(-i, j))
        else
            self
        end
    end
  
    # double-dispatch for adding values
    def add_values v # first dispatch
        v.add_rational self
    end

    def add_int v # second dispatch
        v.add_rational self  # reuse computation of commutative operation
    end

    def add_string v # second dispatch: other is MyString (notice order flipped)
        MyString.new(v.s + i.to_s + "/" + j.to_s)
    end

    def add_rational v # second dispatch: other is MyRational (notice order flipped)
        MyRational.new(v.i * j + i * v.j, v.j * j)
    end

    def mult_values v
        v.mult_rational self
    end

    def mult_int v
        v.mult_rational self
    end

    def mult_string
        raise "Cannot multiply string by rational"
    end

    def mult_rational v
        MyRational.new(v.i * i, v.j * j)
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
        e1.eval.add_values e2.eval
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
        e1.eval.mult_values e2.eval
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
