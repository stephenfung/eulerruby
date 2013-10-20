require './lib/prime_factorizer'
require './lib/functions'

@pf = PrimeFactorizer.new

assert_equal 1, @pf.totient(1)
assert_equal [1, 2, 2, 4, 2, 6, 4, 6, 4], (2..10).map { |n| @pf.totient(n) }
assert_equal [2, Rational(3, 2), 2, Rational(5, 4), 3, Rational(7, 6), 2, 1.5, 2.5], (2..10).map { |n| @pf.n_over_totient(n) }
assert_equal 6, (2..10).max_by { |n| @pf.n_over_totient(n) }
assert_equal 510510, (2..1000000).max_by { |n| @pf.n_over_totient(n) }
