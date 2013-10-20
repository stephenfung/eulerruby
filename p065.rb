require 'rational'
require './lib/functions'
require './lib/continued_fractions'

intparts = [2] + (1..50).inject([]) { |arr, n| arr + [1, 2*n, 1] }

def convergent(intparts, n)
  ContinuedFraction.convert_to_fraction(intparts[0, n])
end

assert_equal Rational(2, 1), convergent(intparts, 1)
assert_equal Rational(3, 1), convergent(intparts, 2)
assert_equal Rational(8, 3), convergent(intparts, 3)
assert_equal Rational(11, 4), convergent(intparts, 4)
assert_equal Rational(19, 7), convergent(intparts, 5)

assert_equal 17, sum_of_digits(convergent(intparts, 10).numerator)

puts sum_of_digits(convergent(intparts, 100).numerator)