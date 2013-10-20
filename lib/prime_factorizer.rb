class PrimeFactorizer
  attr_reader :primes

  def initialize
    @primes = [2, 3, 5]
  end

  def sum_of_proper_divisors(n)
    all_divisors(prime_factorize(n)).inject(0, &:+) - n
  end

  def is_abundant(n)
    sum_of_proper_divisors(n) > n
  end

  def is_prime(n)
    return false if n <= 1
    return true if n <= 3 #Special case for the first couple primes

    #Test if our list of primes is long enough
    if n > @primes.last ** 2
      #Double the size of our list of primes each time
      @primes = primes_sieve(Integer(Math.sqrt(n) + 1) * 4)
    end

    for p in @primes
      return false if n % p == 0
      return true if p ** 2 > n
    end
  end

  #Euler's totient function
  def totient(n)
    prime_factorize(n).inject(1) { |acc, pexp| acc * (pexp[0] - 1) * (pexp[0] ** (pexp[1] - 1)) }
  end

  #n / totient(n)
  def n_over_totient(n)
    prime_factorize(n).inject(Rational(1, 1)) { |acc, pexp| acc * pexp[0] / (pexp[0] - 1) }
  end

  #Returns r for the largest natural number r such that the rth root of n is an integer
  #Should return 6 for 64 (2^6), 3 for 27 (3^3), 1 for 7 (7^1), 1 for 18 (2^1 * 3^2), etc.
  def max_root_integer(n)
    raise ArgumentError("invalid") if n < 2
    exponents = prime_factorize(n).map{|pair| pair.last}
    gcf_list(exponents)
  end

  def gcf_list(list)
    return 1 if list.count == 0
    return list.first if list.count == 1
    list.inject{|acc, n| gcf(acc, n)}
  end

  def gcf(a, b)
    ha = prime_factorize_into_hash(a)
    hb = prime_factorize_into_hash(b)
    ha.keys.each{|p| ha[p] = ([ha[p], hb[p] || 0].min) }
    ha.inject(1){|acc, pair| acc * (pair.first ** pair.last)}
  end

  def lcm(list)
    expand_prime_factorization list.map{ |n| prime_factorize(n) }.inject([]) { |old, i| old + i }.group_by{|pair| pair.first}.map{|prime, factors| factors.max_by{|p, exp| exp}}
  end

  def ensure_primes_up_to(n)
    if @primes.last < n
      @primes = primes_sieve(n * 2)
    end
  end

  #Return an array of prime factors in increasing order
  #e.g. factorize(120) -> [2, 2, 2, 3, 5]
  def factorize(target)
    factors = []

    ensure_primes_up_to(Integer(Math.sqrt(target) + 1))

    while target > 1
      #See if we can find a factor.  If none of the primes up to sqrt(n) can divide n, then it must be prime itself
      factor = @primes.find{|p| target % p == 0} || target

      factors << factor
      target /= factor
    end

    #Return the array of prime factors
    factors
  end

  #e.g. prime_factorize(168) = 2^3 * 3^1 * 7^1 -> [[2, 3], [3, 1], [7, 1]]
  def prime_factorize(target)
    factorize(target).group_by{|x| x}.map{|k,v| [k, v.length]}
  end

  def prime_factorize_into_hash(target)
    prime_factorize(target).inject({}){|h, factor| h[factor.first] = factor.last; h}
  end

  def multiply_prime_factorization(pf1, pf2)
    (pf1 + pf2).group_by{|p, e| p}.map{|g, values| [g, values.inject(0) { |sum, v| sum + v[1]}] }
  end

  def divide_prime_factorization(pf1, pf2)
    multiply_prime_factorization(pf1, pf2.map { |p, e| [p, -e] })
  end

  #e.g. [[2, 3], [3, 1], [7, 1]] -> 168
  def expand_prime_factorization(target)
    target.inject(1) { |total, n| total *= n[0] ** n[1] }
  end

  def all_divisors(prime_factorization)
    return [1] if prime_factorization == nil || prime_factorization == []
    first = prime_factorization.shift
    remaining = all_divisors(prime_factorization)
    first.last.downto(0).map{ |e| (first.first ** e) }.product(remaining).map{|a, b| a * b }
  end

  def all_divisors_prime_factorizations(prime_factorization)
    return [] if prime_factorization == nil || prime_factorization == []
    first = prime_factorization.shift
    remaining = all_divisors_prime_factorizations(prime_factorization)
    if remaining.any?
      first.last.downto(0).map{ |e| [first.first, e] }.tap{|t| "map" + t.inspect}.product(remaining).map{|a, b| [a] + b }
    else
      first.last.downto(0).map{ |e| [[first.first, e]] }
    end
  end

  def num_distinct_prime_factors(n)
    prime_factorize(n).count
  end

  def count_divisors(n)
    prime_factorize(n).inject(1){|old, i| old * (i.last+1)}
  end

  def primes_sieve(max)
    puts "Calculating prime sieve up to #{max}..."
    candidates = (2..max).to_a
    sqrt = Integer(Math.sqrt(max))
    primes = []
    while candidates.first <= sqrt
      primes << first = candidates.first
      candidates.reject!{|x| x % first == 0}  #Also eliminate the first one, since that's been added to our list of primes
    end
    puts "Done calculating prime sieve up to #{max}"
    primes + candidates
  end

  def generate_until(&block)
    my_primes = []
    #Add all the existing primes
    @primes.each do |p|
      return my_primes if yield(p)
      my_primes << p
    end

    #Keep creating new primes until it breaks
    while true do
      p = get_another_prime
      return my_primes if yield(p)
      my_primes << p
    end
  end

  def prime_generator
    Enumerator.new do |g|
      #Yield all our existing primes
      @primes.each{|p| g.yield p}

      while true
        #We ran out of primes... get some more and yield from there.
        old_count = @primes.length
        ensure_primes_up_to(@primes.last * 2)
        #@primes has now been updated to add more.  Yield the new ones
        (old_count...@primes.length).each { |p| g.yield @primes[p] }
      end
    end
  end

end
