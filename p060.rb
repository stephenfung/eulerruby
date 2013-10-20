require './lib/prime_factorizer'
require './lib/functions'

@pf = PrimeFactorizer.new

#Optimizations -- if the set includes 2 or 5, it won't work

def pairwise_concatenatable(s)
  return false if s.any? { |p| p % 3 == 1 } && s.any? { |p| p % 3 == -1 }  #If the set contains both elements that are 1 mod 3 and 2 mod 3, then it won't work
  rv = s.all_subsets_of_size(2).all? { |a, b| @pf.is_prime((a.to_s + b.to_s).to_i) && @pf.is_prime((b.to_s + a.to_s).to_i) }
end

candidates = @pf.primes_sieve(10000)
candidates -= [2, 5]  #We won't include 2 and 5 in our tests since they can't be at the end of a prime

#Start with all subsets of size 2 and work our way up
filtered_candidates = candidates.all_subsets_of_size(2).select { |s| pairwise_concatenatable(s) }
happy_couples = filtered_candidates.inject({}) { |h, ab| a, b = ab; h[a] ? h[a] << b : h[a] = [b]; h[b] ? h[b] << a : h[b] = [a]; h }
happy_couples.each { |k| happy_couples[k] = happy_couples[k].sort if happy_couples[k] }
puts happy_couples.inspect

answers = []
for p1 in happy_couples.keys.to_a.sort
  p1_set = happy_couples[p1]
  for p2 in p1_set
    p2_set = (p1_set & happy_couples[p2])
    for p3 in p2_set
      p3_set = (p2_set & happy_couples[p3])
      for p4 in p3_set
        p4_set = (p3_set & happy_couples[p4])
        for p5 in p4_set
          answers << [p1, p2, p3, p4, p5]
          puts "#{p1}, #{p2}, #{p3}, #{p4}, #{p5}"
        end
      end
    end
  end
end

puts answers.inspect

puts answers.map { |s| s.inject(0, &:+) }.min

#candidates = candidates.all_subsets_of_size(2).select { |s| pairwise_concatenatable(s) }
#puts candidates.inspect
#
#puts "Making and sorting subsets..."
#candidates.all_subsets_of_size(4).sort_by! { |s| s.inject(0, &:+) }
#puts "Done making and sorting subsets"
#
#winner = candidates.find { |s| pairwise_concatenatable(s) }
#puts winner.inspect
#puts winner.inject(0, &:+)