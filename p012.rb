require './lib/functions'
require './lib/prime_factorizer'

pf = PrimeFactorizer.new

for i in (1..100000)
  n = triangle_number(i)
  divisors = pf.count_divisors(n)
  puts divisors
  if divisors > 500
    puts [i, n].inspect
    break
  end
end
