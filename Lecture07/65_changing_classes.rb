# Programming Languages
# Lecture 07: Changing classes

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

r1 = Rectangle.new(3, 4, 5, 8)
puts r1

class Rectangle
    def area
        @w * @h
    end
end

r2 = Rectangle.new(0, 0, 10, 20)
puts r2
puts r2.area

puts r1.area

