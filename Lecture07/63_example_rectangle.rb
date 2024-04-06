# Programming Languages
# Lecture 07: Example, Rectangle

class Rectangle
    attr_accessor :x, :y, :w, :h

    def initialize (x, y, w, h)
        @x = x
        @y = y
        @w = w
        @h = h
    end

    def cx
        @x + w / 2.0
    end

    def cx= new_cx
        @x = new_cx - w / 2.0
    end

    def cy
        @y + h / 2.0
    end

    def cy= new_cy
        @y = new_cy - h / 2.0
    end

    def center
        return self.cx, self.cy
    end

    def to_s
        "Rectangle(" + @x.to_s + ", " + @y.to_s + ", " + @w.to_s + ", " + @h.to_s + ")"
    end

end

r = Rectangle.new(3, 4, 5, 8)
puts r
puts r.cx
puts r.cy
puts r.center
r.cx = 10
r.cy = 20
puts r