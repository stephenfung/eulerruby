require 'test/unit'
require './lib/prime_factorizer'
require './lib/functions'

class TestPrimeFactorizer < Test::Unit::TestCase

  #Project Euler problem 3
  def test_largest_prime_factor
    assert_equal 6857, PrimeFactorizer.new.factorize(600851475143).max
  end

  #Project Euler problem 7
  def test_10001st_prime
    g = PrimeFactorizer.new.prime_generator
    (1..10000).each { |i| g.next }
    assert_equal 104743, g.next
  end

  #Project Euler problem 10
  def test_primes_under_2000000
    #Sieve method
    pf = PrimeFactorizer.new
    primes =  pf.primes_sieve(2000000 - 1)
    assert_equal 142913828922, primes.inject(0, &:+)

    #is-prime method
    assert_equal 142913828922, (1..2000000).select{ |n| pf.is_prime(n) }.inject(0, &:+)
  end

  #Uses part of Project Euler problem 12
  def test_count_divisors
    pf = PrimeFactorizer.new
    assert_equal 16, pf.count_divisors(1000)
    assert_equal 576, pf.count_divisors(76576500)
  end

  #Project Euler problem 5
  def test_lcm
    assert_equal 232792560, PrimeFactorizer.new.lcm(1..20)
  end

  def test_gcf
    pf = PrimeFactorizer.new
    assert_equal 60, pf.gcf(240, 300)
    assert_equal 15, pf.gcf_list([120, 150, 180, 210, 15])
  end

  def test_gcf
    pf = PrimeFactorizer.new
    assert_equal 60, pf.gcf(240, 300)
    assert_equal 15, pf.gcf_list([120, 150, 180, 210, 15])
  end

  def test_max_root_integer
    pf = PrimeFactorizer.new
    assert_equal 6, pf.max_root_integer(64)
    assert_equal 3, pf.max_root_integer(27)
    assert_equal 2, pf.max_root_integer(144)
    assert_equal 1, pf.max_root_integer(7)
    assert_equal 1, pf.max_root_integer(18)
  end

  #Project Euler problem 24
  def test_ordered_permutations
    assert_equal "2783915460", ordered_permutations((0..9).to_a).to_a[999999].join
  end

  def test_letter_score
    assert_equal 53, letter_score("COLIN")
    assert_equal 53, letter_score("Colin")
  end

#  def test_triangle_numbers
#    tn = TriangleNumbers.new
#    mine = (1..100).map { |n| triangle_number(n) }
#    assert_empty (1..triangle_number(100)).{ |n| tn.is_triangle_number(n), mine.include?(n) }
#  end

  def test_pentagonal_numbers
    pn = PentagonalNumbers.new
    pns = (1..100).map { |n| n * ((3*n) - 1) / 2 }
    assert_empty (1..100000).reject{ |n| !!pn.test(n) == !!pns.include?(n) }.tap{|t| puts t.inspect }.map{ |n| [pn.test(n), pns.include?(n)] }.tap { |t| puts t.inspect }
  end

  def test_multiply
    pf = PrimeFactorizer.new
    pf1 = pf.prime_factorize(100)
    pf2 = pf.prime_factorize(98)
    assert_equal [[2, 3], [5, 2], [7, 2]], pf.multiply_prime_factorization(pf1, pf2)
    assert_equal [[2, 1], [5, 2], [7, -2]], pf.divide_prime_factorization(pf1, pf2)
  end

  def test_divisors
    pf = PrimeFactorizer.new
    pf1 = pf.prime_factorize(700)
    pf2 = pf.prime_factorize(98)
    pf.all_divisors_prime_factorizations(pf1).tap{|t| puts t.inspect }
    pf.all_divisors_prime_factorizations(pf2).tap{|t| puts t.inspect }
  end
end