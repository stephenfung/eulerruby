require './lib/functions'
require './lib/continued_fractions'
require 'set'

#If the period is e.g. 4, 1, 6, 4, 1, 6, 4, 1, 6; it can be broken down into a repeating part of 4, 1, 6
def min_period(array)
  (1...array.length).each do |n|
    next unless array.length % n == 0
    if array[0, n] * (array.length / n) == array
      return n
    end
  end
  return array.length
end

def odd(n)
  return n && n % 2 == 1
end

def period(n)
  rv = ContinuedFraction.for_square_root(n)
  return 0 unless rv
  return min_period(rv.last)
end

assert_equal 2, period(11)
assert_equal 4, period(23)
assert_equal [1, 2, 0, 1, 2, 4, 2, 0, 1, 2, 2, 5], (2..13).map { |n| period(n) }
assert_equal 3, min_period([4, 1, 6, 4, 1, 6, 4, 1, 6])
assert_equal 8, min_period([1, 2, 3, 4, 5, 6, 7, 8])
assert_equal 4, (2..13).select { |n| odd(period(n)) }.count

puts (2..10000).select { |n| odd(period(n)) }.count