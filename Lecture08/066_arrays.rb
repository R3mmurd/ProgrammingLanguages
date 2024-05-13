# Programming Languages
# Lecture 08: Arrays

a = [1, 2, 3, 4, 5]

puts a[2]
puts a[0]

puts a.size

puts a[-1]
puts a[-2]

a[1] = 6
a[6] = 14
puts a.size

a[3] = "Hi"

puts a.to_s

b = a + [true, false]
puts b.to_s

c = [3, 2, 3] | [1, 2, 3]
puts c.to_s

# array as tuples
triple = [false, "hi", a[0] + 4]
puts triple.to_s

# Initial size chosen at run-time
xs = Array.new(10)
puts xs.to_s

# Better: initialize with blocks
ys = Array.new(10) { 0 }
puts ys.to_s

zs = Array.new(10) {|i| i * 2 }
puts zs.to_s

# Stacks
puts a.to_s
a.push 5
a.push 7
puts a.pop
puts a.pop
puts a.pop

# queues
puts a.to_s
a.push 11
puts a.shift
puts a.shift
a.unshift 14
puts a.to_s

# slices
f = [2, 4, 6, 8, 10, 12, 14]
puts f[2, 4].to_s
puts f.slice(2, 2).to_s
puts f.slice(-2, 2).to_s
f[2, 4] = [1, 1]
puts f.to_s