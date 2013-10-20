require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

def is_amicable(n, memory)
  candidate = memory[n]
  return candidate != n && (memory[candidate] ||= @pf.sum_of_proper_divisors(candidate)) == n
end

memory = (2...10000).inject({}){|h,n| h[n] = @pf.sum_of_proper_divisors(n); h}

puts (2...10000).select{|n| is_amicable(n, memory)}.inject(0, &:+)
