# Programming Languages
# Lecture 09: Mixins

module Doubler
    def double
        self + self # uses self's + message, not defined in Doubler
    end
end
  
class Point2D
    attr_accessor :x, :y
    
    include Doubler

    def initialize(x=0, y=0)
        @x = x
        @y = y
    end

    def + other
        ans = Point2D.new
        ans.x = self.x + other.x
        ans.y = self.y + other.y
        ans
    end

    def to_s
        "(#{@x}, #{@y})"
    end
end

point2D = Point2D.new(1, 2)
puts point2D
puts point2D.double
  
class String
    include Doubler
end

s = "abc"
puts s
puts s.double

# this is more questionable style because the mixin is using an
# instance variable that could clash with classes and has to be initialized
module Color 
    def color
        @color
    end

    def color= c
        @color = c
    end

    def darken
        self.color = "dark " + self.color
    end
end
  
class Point3D < Point2D
    attr_accessor :z
    # rest of definition omitted (not so relevant)
end
  
class ColorPoint2D < Point2D
    include Color
end
  
class ColorPoint3D < Point3D
    include Color
end
  