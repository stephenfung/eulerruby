require './lib/functions'
require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

#Dynamic programming algorithm
#Let x[i, j] be the number of ways you can write i as a sum of primes p each <= j

x = Hash.new(0)

i = 2
while true #loop on i
  for j in (1..i)
    #All the ways of writing i without using j
    x[[i, j]] = x[[i, j-1]]
    if @pf.is_prime(j)
      #If x is a multiple of the prime, then count that solution pj + pj + ... + pj
      x[[i, j]] += 1 if i % j == 0

      #Use the number j once, twice, ... k times
      k = 1
      while j * k < i
        x[[i,j]] += x[[i - j*k, [j-1, i - j*k].min]] #Use j k times, then the number of ways you can write the smaller number without using j
        k += 1
      end
    end
  end
  if x[[i, i-1]] > 5000
    puts "#{i}, #{x[[i, i-1]]}"
    break
  end
  i += 1
end
assert_equal 5, x[[10, 9]]
assert_equal 5006, x[[71, 70]]