require './lib/functions'

puts pythagorean_triplet_generator(1000).find { |a, b, c| a + b + c == 1000 }.inject(1, &:*)
