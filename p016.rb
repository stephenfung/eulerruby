puts (2**1000).to_s.chars.inject(0){|acc, i| acc + i.to_i }