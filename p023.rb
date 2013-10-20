require './lib/prime_factorizer'

pf = PrimeFactorizer.new

abundants = (1..28123).select{|n| pf.is_abundant(n)}
puts abundants.count
#sums = abundants.product(abundants).inject({}){|h,pair| h[pair.inject(0, &:+)] = 1; h}
#puts (1..28123).reject{|n| sums.include? n}.inject(0, &:+)