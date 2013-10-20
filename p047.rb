require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

def solve
  consecutive_fours = 0
  (2..100000000000).each do |n|
    if @pf.num_distinct_prime_factors(n) >= 4
      consecutive_fours += 1
      if(consecutive_fours >= 4)
        return n-3
      end
    else
      consecutive_fours = 0
    end
  end
end

puts solve