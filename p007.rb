require './lib/prime_factorizer'
g = PrimeFactorizer.new.prime_generator
(1..10000).each { |i| g.next }
puts g.next
