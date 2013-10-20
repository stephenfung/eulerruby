require './lib/prime_factorizer'
require './lib/functions'

@pf = PrimeFactorizer.new

puts (2..1000000).inject(0) { |acc, i| acc + @pf.totient(i) }
