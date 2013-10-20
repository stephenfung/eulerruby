require './lib/prime_factorizer.rb'

def has_arithmetic_sequence(array)
  as = []
  for i in (0...array.length-2)
    for j in (i+1...array.length-1)
      for k in (j+1...array.length)
        as << [array[i], array[j], array[k]] if array[j] - array[i] == array[k] - array[j]
      end
    end
  end
  as
end

@pf = PrimeFactorizer.new

four_digit_primes = (1000..9999).select { |p| @pf.is_prime(p) }
groups = four_digit_primes.group_by { |p| p.to_s.chars.sort }
sequences = groups.map { |g, values| has_arithmetic_sequence(values) }.select { |g| g.any? }
sequences.map { |s| s.join }.tap { |t| puts t.inspect }