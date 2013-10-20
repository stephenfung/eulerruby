require './lib/prime_factorizer'

primes =  PrimeFactorizer.new.primes_sieve(2000000 - 1)
puts primes.inject(0, &:+)
