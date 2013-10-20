puts (1..100).to_a.product((1..100).to_a).map { |a, b| (a**b).to_s.chars.to_a.inject(0){|sum, c| sum + c.to_i} }.max
