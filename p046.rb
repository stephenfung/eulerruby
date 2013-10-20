require './lib/functions'
require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

def is_odd_composite(n)
  (n % 2 == 1) && !@pf.is_prime(n) && n != 1
end

ds = DoubleSquares.new

puts (1..1000000).find{|n| is_odd_composite(n) && ds.all_below(n).all? { |i| !@pf.is_prime(n - i) } }