require './lib/functions'
require './lib/prime_factorizer'
#No 9-digit pandigitals will be prime because the sum of the digits will be 9 * 5 = 45 so it's divisible by 3
#Ditto with 8-digit pandigitals because sum of digits = 36 so it's divisible by 3
@pf = PrimeFactorizer.new

puts descending_pandigitals(7).find { |n| @pf.is_prime(n) }
