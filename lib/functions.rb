require 'set'

def assert_equal(a, b)
  raise Exception.new("Assertion failed: #{a.inspect} #{b.inspect}") unless a == b
  puts "Assertion passed: #{a.inspect}"
end

class SequenceTester
  attr_reader :members

  def initialize(sequence_generator)
    @sequence_generator = sequence_generator
    @members = []
    @members_to_sequence = {}
  end

  def test(n)
    ensure_up_to(n)
    while((@members.last || 0) < n)
      @members << @sequence_generator.call(@members.length + 1)
      @members_to_sequence[@members.last] = @members.length
    end
    return @members_to_sequence[n]
  end

  def all_below(n)
    ensure_up_to(n)
    @members.select{ |i| i < n }
  end

  def ensure_up_to(n)
    while((@members.last || 0) < n)
      @members << @sequence_generator.call(@members.length + 1)
      @members_to_sequence[@members.last] = @members.length
    end
  end

end

def triangle_number(n)
  n * (n+1) / 2
end

def is_permutation(x, y)
  xs = x.to_s
  ys = y.to_s
  return false unless xs.length == ys.length
  return xs.chars.sort.join == ys.chars.sort.join
end

class TriangleNumbers < SequenceTester
  def initialize
    super(method(:triangle_number))
  end

  def is_triangle_number(n)
    test(n)
  end
end

def pentagonal_number(n)
  (n * (3*n - 1)) / 2
end

def is_square(n)
  n == Integer(Math.sqrt(n)) ** 2
end

def is_pentagonal(n)
  is_square(24*n + 1) && ((Math.sqrt(24*n + 1) + 1) % 6 == 0)
end

def coprime(x, y)
  gcf2(x, y) == 1
end

def gcf2(x, y)
  #Assume x > y
  x, y = [x, y].sort.reverse
  z = x % y
  while x % y != 0
    x, y = y, z
    z = x % y
  end
  y
end

class PentagonalNumbers < SequenceTester
  def initialize
    super(method(:pentagonal_number))
  end

  def test(n)
    is_pentagonal(n)
  end
end

def hexagonal_number(n)
  n * (2 * n - 1)
end

class HexagonalNumbers < SequenceTester
  def initialize
    super(method(:hexagonal_number))
  end
end

def heptagonal_number(n)
  n * (5 * n - 3) / 2
end

class HeptagonalNumbers < SequenceTester
  def initialize
    super(method(:heptagonal_number))
  end
end

def octagonal_number(n)
  n * (3 * n - 2)
end

class OctagonalNumbers < SequenceTester
  def initialize
    super(method(:octagonal_number))
  end
end

def square_number(n)
  n * n
end

class SquareNumbers < SequenceTester
  def initialize
    super(method(:square_number))
  end
end

class MinPentagonalDifference < SequenceTester
  def initialize
    super(Proc.new{ |n| pentagonal_number(n+1) - pentagonal_number(n) })
  end
end

class DoubleSquares < SequenceTester
  def initialize
    super(Proc.new{ |n| 2*n*n })
  end
end

def is_palindrome(n, base=10)
  n.to_s(base).reverse == n.to_s(base)
end

def pythagorean_triplet_generator(max_a_b)
  Enumerator.new do |g|
    (1..max_a_b).each do |a|
      (1..max_a_b).each do |b|
        c = a**2 + b**2
        if is_square(c)
          g.yield(a, b, Integer(Math.sqrt(c)))
        end
      end
    end
  end
end

def factorial(n)
  (1..n).inject(1, &:*)
end

def choose(n, r)
  n.downto(n-r + 1).inject(1) { |p, i| p * i } / factorial(r)
end

def ordered_permutations(list)
  return [list] if list.length == 1
  return [] if list == []
  perms = []
  list.each_with_index do |element, index|
    others = list.clone
    others.delete_at(index)
    perms += ordered_permutations(others).map { |p| [element] + p }
  end
  perms
end

#Returns a list of lists
def power_set(list)
  return [[]] if list.count == 0
  head = list.first
  helper = power_set(list.tail)
  return helper + helper.map { |h| [head] + h }
end

def descending_pandigitals(n)
  ordered_permutations((1..n).to_a.reverse).map { |n| n.join.to_i }
end

def letter_score(word)
  word.upcase.chars.inject(0){|acc, c| acc + c.ord - 'A'.ord + 1}
end


def parse_line(s)
  names = []
  match = nil
  while match = /"([A-Z]+)"/.match(s, match ? match.end(0) : 0)
    names << match[1]
  end
  names
end

#Follows the format of problem 42 and problem 22
def parse_file(filename)
  names = []
  File.open(filename, "r") do |file|
    while(line = file.gets)
      names += parse_line(line)
    end
  end
  names
end

#Adds leading zeroes to pad to the specified number of digits
def padded_itoa(n, num_digits=0)
  "%0#{num_digits}d" % n
end

def spiral_corners(n)
  return [1] if n == 1
  raise ArgumentError("Not implemented") if n % 2 == 0 || n < 1
  #n**2 + (n**2 - (n-1)) + (n**2 - 2(n-1)) + (n**2 - 3(n-1))
  [n**2, n**2 - (n-1), n**2 - 2*(n-1), n**2 - 3*(n-1)]
end

def sum_of_digits(n)
  n.to_s.chars.inject(0) { |sum, c| sum + c.to_i }
end

module Enumerable
  def tail()
    first, *rest = *self
    rest
  end

  def all_same?
    first = self.first
    self.all? { |x| x == first }
  end
end

class Array
  def all_subsets_of_size(n)
    return [] if n > self.length
    return self.map { |e| [e] } if n == 1

    rv = []
    self.each_with_index do |e, i|
      rv += self[i + 1, self.length].all_subsets_of_size(n-1).map { |subset| [e] + subset }
    end
    rv
  end
end