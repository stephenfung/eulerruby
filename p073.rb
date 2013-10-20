require './lib/prime_factorizer'
require './lib/functions'

assert_equal 1, gcf2(13, 17)
assert_equal 13, gcf2(13, 26)
assert_equal 13, gcf2(13, 13)
assert_equal 2, gcf2(26, 28)
assert_equal 10, gcf2(60, 110)

def number_fractions_between(lower_bound, upper_bound, denominator)
  ub = (denominator * upper_bound - 1).ceil
  lb = (denominator * lower_bound + 1).floor
  (lb..ub).count { |i| gcf2(i, denominator) == 1 }
end

lb = Rational(1, 3)
ub = Rational(1, 2)
assert_equal 3, (2..8).inject(0) { |acc, d| acc + number_fractions_between(lb, ub, d) }

puts (2..12000).inject(0) { |acc, d| acc + number_fractions_between(lb, ub, d) }

