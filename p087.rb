require './lib/functions'
require './lib/prime_factorizer'
require 'set'

@pf = PrimeFactorizer.new

MAX = 50000000 - 1

def collect_until_max
  rv = []
  i = 1
  while true
    next_num = yield(i)
    if next_num
      return rv if next_num >= MAX
      rv << next_num
    end
    i += 1
  end
#  i = 1
#  while((next_num = yield(i)) && next_num < MAX)
#    rv << next_num if next_num
#    i += 1
#  end
#  rv
end

prime_squares = collect_until_max { |i| i ** 2 if @pf.is_prime(i) }
prime_cubes = collect_until_max { |i| i ** 3 if @pf.is_prime(i) }
prime_fourths = collect_until_max { |i| i ** 4 if @pf.is_prime(i) }

seen = Set.new
count = 0
for p4 in prime_fourths
  for p3 in prime_cubes
    break if p3 + p4 > MAX
    for p2 in prime_squares
      sum = p2 + p3 + p4
      break if sum > MAX
      unless seen.include?(sum)
        count += 1
        seen.add(sum)
      end
    end
  end
end

puts count
#
#puts prime_squares.inspect
#puts prime_cubes.inspect
#puts prime_fourths.inspect