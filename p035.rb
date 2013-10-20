require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

def rotations(s)
  rotations = [s]
  (s.length - 1).times { rotations << rotations.last[-1] + rotations.last[0, rotations.last.length-1] }
  rotations
end

def is_circular_prime(n)
  sn = n.to_s
  return false if sn.length > 1 && ["0", "2", "4", "6", "8"].any? { |c| sn.include? c }
  return rotations(n.to_s).all? { |ns| @pf.is_prime(ns.to_i) }
end

circular_primes = (2...1000000).select { |n| is_circular_prime(n) }
puts circular_primes.inspect
puts circular_primes.count
