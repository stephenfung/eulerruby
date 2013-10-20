require './lib/functions'

pent = PentagonalNumbers.new
tri = TriangleNumbers.new

def hexagonal_number(n)
  n * (2*n - 1)
end
n = (144..100000).find{|n| pent.test(hexagonal_number(n)) && tri.test(hexagonal_number(n))}
puts hexagonal_number(n)
