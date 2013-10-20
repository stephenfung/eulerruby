require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

def f(a, b, n)
  (n**2) + (a*n) + b
end

def max_consecutive_primes(a, b)
  #Since n^2 + a*n + b must be >= 2 for n = 0, then b must be >= 2
  #Since n^2 + a*n + b must be >= 2 for n = 1, then 1 + a + b must be >= 2, i.e. a + b >= 1
  return 0 if b < 2
  return 0 if a + b < 1

  i = 0
  while @pf.is_prime(f(a, b, i))
    i += 1
  end
  #puts "(#{a}, #{b}) = #{i}"
  i
end

r = (-999..999)
pair = r.to_a.product(r.select{|b| @pf.is_prime(b)}.to_a).max_by{|a, b| max_consecutive_primes(a, b)}
puts pair.inject(1, &:*)
