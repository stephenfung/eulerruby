require './lib/functions'

require './lib/prime_factorizer'

@pf = PrimeFactorizer.new

#a < m < n < s
#f(n) - f(m) = f(a)
#f(n) + f(m) = f(s)
#Therefore
#f(s) - f(n) = f(m)
#f(s) - f(a) = 2f(m)
#f(s) - f(n) iff (s-n)(3s + 3n - 1) = m(3m-1)
#f(s) - f(a) = 2f(m) iff (s-a)(3s + 3a - 1) = 2m(3m-1) = 2(s-n)(3s + 3n - 1)

def is_difference_of_pentagonal_numbers(pn)
  pf1 = @pf.prime_factorize(2*pn)

  divisors = @pf.all_divisors_prime_factorizations(pf1.clone)

  matches = []
  divisors.each do |pfd|
    pfother = @pf.divide_prime_factorization(pf1, pfd)
    p1_minus_p2 = @pf.expand_prime_factorization(pfd)
    other = @pf.expand_prime_factorization(pfother)
    if (other % 3) == 2 && (b = (other + 1)/3) > p1_minus_p2 && (p1_minus_p2 % 2 == b % 2)
      matches << m = [(b-p1_minus_p2)/2, (b+p1_minus_p2)/2]
    end
  end
  matches
end

puts pentagonal_number(1020)
puts pentagonal_number(1912)
puts pentagonal_number(2167)
puts pentagonal_number(2395)

#(1..10000).map {|n| pentagonal_number(n)}.each do |m|
(1..1000000).each do |m|
  matches = is_difference_of_pentagonal_numbers(pentagonal_number(m))
  doublematches = is_difference_of_pentagonal_numbers(2 * pentagonal_number(m))
  puts "Testing #{m}"

  if (intersect = matches.map{ |a, b| b } & doublematches.map { |a, b| b }).any?
#    matches.each { |a, b| puts "Match f(#{m}) == f(#{b}) - f(#{a})" }
#    doublematches.each { |a, b| puts "DoubleMatch 2*f(#{m}) == f(#{b}) - f(#{a})" }
    puts intersect.inspect
    puts m
    break
#    raise ArgumentError("GOTCHA!")
  end

end

#a = 1
#while(true)
#  pf = @pf.prime_factorize(a * 3*a - 1)
#
#  a += 1
#end