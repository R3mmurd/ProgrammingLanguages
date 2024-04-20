# Programming Languages
# Lecture 08: Subclassing

class Point
    attr_accessor :x, :y
  
    def initialize(x, y)
        @x = x
        @y = y
    end

    def dist_from_origin
        Math.sqrt(@x * @x + @y * @y) # why a module method? Less OOP :-(
    end

    def dist_from_origin2
        Math.sqrt(x * x + y * y) # uses getter methods
    end
  
end
  
class ColorPoint < Point
    attr_accessor :color

    def initialize(x, y, c = "clear") # or could skip this and color starts unset
        super(x, y) # keyword super calls same method in superclass
        @color = c
    end
end
  
# example uses with reflection
p  = Point.new(0, 0)
cp = ColorPoint.new(0, 0, "red")
puts p.class                           # Point
puts p.class.superclass                # Object
puts cp.class                          # ColorPoint
puts cp.class.superclass               # Point
puts cp.class.superclass.superclass    # Object
puts cp.is_a? Point                    # true
puts cp.instance_of? Point             # false
puts cp.is_a? ColorPoint               # true
puts cp.instance_of? ColorPoint        # true