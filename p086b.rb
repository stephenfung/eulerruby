require './lib/functions'


def ns_for_m(m)
  (1...m).select { |n| ((n % 2) != (m % 2)) && coprime(m, n) }
end

def fundamental_pythagorean_triplets(max_mn)
  (1..max_mn).inject([]) { |all, m| all + [m].product(ns_for_m(m)) }.map { |m, n| [m**2 - n**2, 2 * m * n,m**2 + n**2].sort }
end

def all_pythagorean_triplets_with_first_or_second_element(c)
  triplets = []
  @f.each do |x, y, z|
    if c % y == 0
      triplets << [x * c / y, c, z * c / y]
    end
    if c % x == 0
      triplets << [c, y * c / x, z * c / x]
    end
  end
  triplets
end

@f = fundamental_pythagorean_triplets(100)

count = 0
for m in 1..10000
  candidates = all_pythagorean_triplets_with_first_or_second_element(m)
  for a, b, c in candidates
    if a == m
      #How many unique pairs are there that sum to b but are <= a
      #The bigger number must be between ceil(b/2) and a
      count += [0, a - ((b+1)/2) + 1].max
    end
    if b == m
      #How many unique pairs of integers are there that sum to a
      count += a/2
    end
  end
  puts "#{m} has count #{count}"
  exit if count > 1000000
end

