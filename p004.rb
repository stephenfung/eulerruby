require './lib/prime_factorizer'
require './lib/functions'

def p004_palindromes
  #the product of 2 3-digit number must be less than 1000^2
  999999.downto(1).select{|n| is_palindrome(n)}
end

def is_3_digits(n)
  (100..999).include? n
end

prime_factorizer = PrimeFactorizer.new
puts p004_palindromes.find{ |palin| prime_factorizer.all_divisors(prime_factorizer.prime_factorize(palin)).map{ |d| [d, palin / d] }.any?{|pair| pair.all? { |n| is_3_digits(n) } } }
