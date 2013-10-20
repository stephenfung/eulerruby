require './lib/prime_factorizer'
require './lib/functions'

@pf = PrimeFactorizer.new

def largest_below_for_denominator(constant, denominator)
  i = (denominator * constant - 1).ceil
  while @pf.gcf(denominator, i) != 1
    i -= 1
  end
  return i
end

constant = Rational(3, 7)
assert_equal 2, largest_below_for_denominator(constant, 5)
assert_equal 3, largest_below_for_denominator(constant, 8)
assert_equal 2, largest_below_for_denominator(constant, 7)
assert_equal 5, largest_below_for_denominator(constant, 14)

puts (3...10**6).map { |d| Rational(largest_below_for_denominator(constant, d), d) }.max.numerator