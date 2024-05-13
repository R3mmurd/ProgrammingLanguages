# Programming Languages
# Lecture 09: Multiple Inheritance

class Point2D
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def distToOrigin
        Math.sqrt(x * x  + y * y)
    end
end
  
class ColorPoint2D < Point2D
    attr_accessor :color

    def initialize(x, y, color)
        super(x, y)
        @color = color
    end
    
    def darken
        self.color = "dark " + self.color
    end
end
  
class Point3D < Point2D
    attr_accessor :z

    def initialize(x, y, z)
        super(x, y)
        @z = z
    end

    def distToOrigin
        Math.sqrt(x * x  + y * y + z * z)
    end
end
  
  
# This does not exist in Ruby (or Java/C#, it does in C++)
  
# class ColorPoint3D < ColorPoint, Point3D
# end
  
# two ways we could actually make 3D Color Points:
  
class ColorPoint3D_1 < ColorPoint2D
    attr_accessor :z

    def initialize(x, y, z, color)
        super(x, y, color)
        @z = z
    end

    def distToOrigin
        Math.sqrt(x * x  + y * y + z * z)
    end
end
  
class ColorPoint3D_2 < Point3D
    attr_accessor :color
    
    def initialize(x, y, z, color)
        super(x, y, z)
        @color = color
    end

    def darken
        self.color = "dark " + self.color
    end
end
  