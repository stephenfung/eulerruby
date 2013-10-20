require './lib/functions'
require 'set'

def has_no_duplicates(s)
  s.chars.to_a.uniq.length == s.length
end

def process(array)
  array.map { |n| "%03d" % n }.select { |s| has_no_duplicates(s) }
end

def to_pandigital(s)
  (Set.new("0123456789".chars) - Set.new(s.chars)).to_a[0].to_s + s
end

class Array
  def prefix_combine(d1)
    d2 = self
    d1.product(d2).select { |s1, s2| s1[1, 2] == s2[0, 2] }.map { |s1, s2| s1[0, 1] + s2 }.select { |s| has_no_duplicates(s) }
  end
end

d2 =  process (1...1000).select { |n| n % 2 == 0 }
d3 =  process (1...1000).select { |n| n % 3 == 0 }
d5 =  process (1...1000).select { |n| n % 5 == 0 }
d7 =  process (1...1000).select { |n| n % 7 == 0 }
d11 = process (1...1000).select { |n| n % 11 == 0 }
d13 = process (1...1000).select { |n| n % 13 == 0 }
d17 = process (1...1000).select { |n| n % 17 == 0 }

matching = d17.prefix_combine(d13).prefix_combine(d11).prefix_combine(d7).prefix_combine(d5).prefix_combine(d3).prefix_combine(d2)
pandigitals = matching.map { |s| to_pandigital(s) }
puts pandigitals.inject(0) { |sum, s| sum + s.to_i }

