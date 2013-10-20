megastring = (1..300000).inject(""){ |s, n| s << n.to_s }
puts megastring.length
digits = [1, 10, 100, 1000, 10000, 100000, 1000000].map { |d| megastring[d-1] }
puts digits.inspect
puts digits.inject(1){|p, d| p * d.to_i}