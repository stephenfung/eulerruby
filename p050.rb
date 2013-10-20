require './lib/prime_factorizer'

def consecutive_sums(primes, num_elements)
  (num_elements - 1...primes.length).map { |i| primes[i] - (i >= num_elements ? primes[i-num_elements] : 0) }
end

max = 10 ** 6
@pf = PrimeFactorizer.new
primes = @pf.primes_sieve(max / 20) #Since the longest sequence < 1000 has 20 elements already, we can do an optimization to avoid calculating the largest primes
prime_sums = primes.inject([]) { |sums, p| sums << p + (sums.last || 0) }

for i in (1...primes.length).to_a.reverse
  newbies = consecutive_sums(prime_sums, i).select { |n| n < max && @pf.is_prime(n) }
  if newbies.any?
    puts i, newbies.max if newbies.any?
    break
  end
end