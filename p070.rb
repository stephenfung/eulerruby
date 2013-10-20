require './lib/prime_factorizer'
require './lib/functions'

assert_equal true, is_permutation(12345, 53124)
assert_equal false, is_permutation(12345, 112345)
assert_equal false, is_permutation(12345, 12346)

@pf = PrimeFactorizer.new

valid = (2...10**7).select { |n| is_permutation(n, @pf.totient(n)) }
puts valid.inspect
puts valid.min_by { |n| @pf.n_over_totient(n) }

(1..1000).each { |n| puts @pf.totient(n) }