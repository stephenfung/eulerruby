require './lib/functions'
require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

puts "Generating primes..."
@pf.ensure_primes_up_to(10 ** 6)

total_primes = 0
total_non_primes = 1
side_length = 1

while (total_primes * 10) >= (total_primes + total_non_primes) || side_length == 1
  side_length += 2
  #the tail call is to ignore the square number in the first position
  a = spiral_corners(side_length).tail.select { |n| @pf.is_prime(n) }.count
  total_primes += a
  total_non_primes += (4-a)
  puts "Side Length #{side_length}: #{total_primes} / #{total_primes + total_non_primes}"
end

puts side_length