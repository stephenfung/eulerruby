require './lib/functions'

puts (23..100).inject(0) { |sum, n| sum + (0..n).count { |r| choose(n, r) > 1000000 } }