n = (1..100).inject(1, &:*)
puts n.to_s.chars.inject(0){|acc, c| acc + c.to_i}