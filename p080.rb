require './lib/functions'
require 'bigdecimal'

def hundred_digits(n)
  return 0 if is_square(n)
  sum_of_digits(BigDecimal.new(n.to_s).sqrt(100).to_s[2,100])
end

assert_equal 475, hundred_digits(2)
assert_equal 0, hundred_digits(4)
assert_equal 40886, (1..100).inject(0) { |sum, n| sum + hundred_digits(n) }