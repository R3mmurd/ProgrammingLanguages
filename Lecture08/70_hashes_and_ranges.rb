# Programming Languages
# Lecture 08: Hashes and Ranges

h1 = {}
h1["a"] = "Found A"
h1[false] = "Found false"
puts h1["a"]
puts h1[false]
puts h1[42]
puts h1.to_s
puts h1.keys.to_s
puts h1.values.to_s
h1.delete("a")
puts h1.to_s

h2 = {"SML" => 1, "Racket" => 2, "Ruby" => 3}
puts h2.to_s
puts h2["SML"]

# Symbols are like strings, but cheaper.  Often used with hashes.
h3 = {:sml => 1, :racket => 2, :ruby => 3}
puts h3.to_s
puts h3[:sml]

# each for hashes best with 2-argument block
h2.each {|k, v| puts "#{k}: #{v}"}

# ranges
puts (1..100).inject {|acc, item| acc + item}

def foo a
  a.count {|x| x * x < 50}
end

class Dummy
  def count
    1000
  end
end

# duck typing in foo
puts foo [3, 5, 7, 9]
puts foo (3..9)
puts foo Dummy.new