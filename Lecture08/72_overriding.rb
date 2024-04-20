# Programming Languages
# Lecture 08: Overriding and Dynamic Dispatch

class Point2D
    attr_accessor :x, :y
  
    def initialize(x,y)
        @x = x
        @y = y
    end

    def dist_from_origin
        Math.sqrt(@x * @x  + @y * @y) # uses instance variables directly
    end

    def dist_from_origin2
        Math.sqrt(x * x + y * y) # uses getter methods
    end
  
  end
  
# design question: "Is a 3D-point a 2D-point?" 
# [arguably poor style here, especially in statically typed OOP languages]
class Point3D < Point2D
    attr_accessor :z

    def initialize(x,y,z)
        super(x,y)
        @z = z
    end

    def dist_from_origin
        d = super
        Math.sqrt(d * d + @z * @z)
    end

    def dist_from_origin2
        d = super
        Math.sqrt(d * d + z * z)
    end
end

class PolarPoint < Point2D
    # Interesting: by not calling super constructor, no x and y instance vars
    def initialize(r, theta)
        @r = r
        @theta = theta
    end

    def x
        @r * Math.cos(@theta)
    end

    def y
        @r * Math.sin(@theta)
    end

    def x= a
        b = y
        @theta = Math.atan2(b, a)
        @r = Math.sqrt(a * a + b * b)
        self
    end

    def y= b
        a = x # avoid multiple calls to x method
        @theta = Math.atan2(b, a)
        @r = Math.sqrt(a * a + b * b)
        self
    end

    def dist_from_origin # must override since inherited method does wrong thing
        @r
    end
    # inherited dist_from_origin2 already works!!
end

# the key example
pp = PolarPoint.new(4, Math::PI / 4)
puts pp.x
puts pp.y
puts pp.dist_from_origin2
