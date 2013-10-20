require './lib/prime_factorizer'
require './lib/functions'
require 'set'

@pf = PrimeFactorizer.new

def construct_families(num_digits, fixed_mask)
  num_free_digits = num_digits - fixed_mask.length

  #Ignore this degenerate cases where nothing is replaced or everything is replaced
  return [] if [0, num_digits].include?(num_free_digits)

  #Optimization; ignore cases where the fixed_mask includes the last digit, because that'll be mostly even numbers
  return [] if fixed_mask.include?(num_digits - 1)

  #Optimization; ignore cases where the # of digits in the mask isn't a multiple of three, because then
  #at least 3 of the numbers of each family will be multiples of 3
  return [] if fixed_mask.length % 3 != 0

  families = []
  (0...10**num_free_digits).each do |free|
    #To an array of digits with leading zeroes
    frees = padded_itoa(free, num_free_digits).chars.map { |c| c.to_i }

    #Create the families of numbers with the fixed digits mixed with the free digits based on the mask
    #e.g. if num_digits = 5, mask = [0, 2], frees = "987" it'll generate [09087, 19187, 29287, 39387, ... 99987]
    families << (0..9).map do |d|
      s = 0#s = ""
      used = 0
      (0...num_digits).each do |i|
        if fixed_mask.include?(i)
          #s += d.to_s
          s *= 10
          s += d
        else
          #s += frees[used]
          s *= 10
          s += frees[used]
          used += 1
        end
      end
      s
    end
  end
  families
end

#puts construct_families(5, [0, 2]).inspect

#Returns the set of number families that can be generated with num_digits digits where digit "repeated" appears exactly repeated_num times
def number_families(num_digits)
  #As an optimization, we can exclude masks that have the last digit being replaced, because it'll never hit 8 primes
  #since most of those will be even numbers.
  subgroups = power_set(0...num_digits-1)
  families = []
  subgroups.each do |fixed_mask|
    families += construct_families(num_digits, fixed_mask)
  end
  families
end

families = number_families(6).map { |f| f.select { |n| @pf.is_prime(n) } }.select { |f| f.count >= 8 }
puts families.inspect
puts families.map { |f| f.min }.inspect
puts families.flatten.min.inspect
