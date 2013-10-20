require './lib/functions'

def is_base2_and_base10_palindrome(n)
  #Shortcut, even numbers can't be palindromes base 2 because no leading zeroes
  return false if n % 2 == 0
  is_palindrome(n, 2) && is_palindrome(n, 10)
end

palindromic = (1...1000000).select { |n| is_base2_and_base10_palindrome(n) }
puts palindromic.inspect
puts palindromic.inject(0, &:+)
