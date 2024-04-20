# Programming Languages
# Lecture 08: Procs

a = [3, 5, 7, 9]

puts a.count {|x| x >= 6}

# No need for Procs here
b = a.map {|x| x * x}

puts b.count {|x| x >= 6}

# Need Procs here, want an array of functions
c = a.map {|x| lambda {|y| x >= y}}

# Elements of c are Proc objects with a call method
puts c[2].call 17

puts c.count {|x| x.call(5)}