# Programming Languages
# Lecture 08: Blocks

class MyVector
    attr_reader :size

    def initialize
        @array = []
        @size = 0
    end

    def push_back item
        @array[@size] = item
        @size = @size + 1
    end

    def pop_back
        if @size > 0
            @size = @size - 1
        end
        @array[@size]
    end

    def back
        @array[@size - 1]
    end

    def for_each
        for item in @array
            yield(item)
        end
    end

    def for_each_enum
        i = 0
        until i == @size
            yield(@array[i], i)
            i = i + 1
        end
    end

    def filter
        result = MyVector.new

        for item in @array
            if yield(item)
                result.push_back(item)
            end
        end

        result
    end

    def map
        result = MyVector.new

        for item in @array
            result.push_back(yield(item))
        end

        result
    end

    def fold init
        accum = init

        for item in @array
            accum = yield(accum, item)
        end

        accum
    end

    def to_s
        @array.to_s
    end
end

v = MyVector.new

v.push_back(1)
v.push_back(2)
v.push_back(3)
v.push_back(4)
v.push_back(5)

v.for_each { puts "hi" }
v.for_each {|item| puts item * 2}
v.for_each_enum {|item| puts item * 2}
v.for_each_enum {|item, idx| puts "array[#{idx}] = #{item}"}

f = v.filter {|item| item % 2 == 0}
puts f.to_s

m = v.map {|item| item * item }
puts m.to_s

s = v.fold(0) {|accum, item| accum + item}
puts s
p = v.fold(1) {|accum, item| accum * item}
puts p