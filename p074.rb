require './lib/functions'
require 'set'

@digit_factorials = {}
@terminators = {1 => 1, 2 => 1, 145 => 1, 169 => 3, 363601 => 3, 1454 => 3, 871 => 2, 45361 => 2, 45362 => 2, 872 => 2 }
@chain_length = {}

def factorial(n)
  n.downto(1).inject(1) { |prod, i| prod * i }
end

(0..9).each { |i| @digit_factorials[i] = factorial(i) }

def factorial_of_digits(n)
  @digit_factorials[n] ||= n.to_s.chars.map { |c| c.to_i }.inject(0) { |sum, d| sum + @digit_factorials[d.to_i] }
end

#Should only calculate for this once
puts factorial_of_digits(871)
puts factorial_of_digits(871)

assert_equal 363601, factorial_of_digits(169)

puts "Digit factorials calculated"

#def digit_factorial_chain(n)
#  seen = Set.new([n])
#  while true
#    n = factorial_of_digits(n)
#    if seen.include?(n)
#      @terminators.add(n)
#      return seen.count
#    end
#    seen.add(n)
#
#  end
#end

def digit_factorial_chain(n)
  list = []
  until @chain_length.include?(n) || @terminators.include?(n)
    list << n
    n = factorial_of_digits(n)
    #Check if we've found another number that leads to itself
    if n == list.last
      @terminators[n] = 1
      list.pop
    end
  end
  if @terminators.include?(n)
    chain_length = list.length + @terminators[n]
  elsif @chain_length.include?(n)
    chain_length = list.length + @chain_length[n]
  end
  list.each_with_index do |n, i|
    @chain_length[n] = chain_length - i
  end
  chain_length
end

assert_equal 3, digit_factorial_chain(169)
assert_equal 5, digit_factorial_chain(69)

assert_equal 402, (1...1000000).select { |n| digit_factorial_chain(n) == 60 }.count
