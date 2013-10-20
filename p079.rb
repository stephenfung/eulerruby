require './lib/functions'

#Recurrence relation method
#http://en.wikipedia.org/wiki/Partition_(number_theory)#Generating_function

def generalized_pentagonal_sequence(n)
  #Convert n  = 1, 2, 3, ... to 1, -1, 2, -2, 3, -3, ... and then convert to pentagonal number
  #via n(3n-1) / 2
  k = (n % 2 == 0) ? -((n+1)/2) : (n+1)/2
  k * (3*k - 1) / 2
end

class GeneralizedPentagonalNumbers < SequenceTester
  def initialize
    super(method(:generalized_pentagonal_sequence))
  end

  def is_triangle_number(n)
    test(n)
  end
end

@memoize = [1]

@pn = GeneralizedPentagonalNumbers.new

def partition(n)
  return @memoize[n] if @memoize[n]
  #puts "calculating for #{n}"
  @pn.ensure_up_to(n)
  gps = @pn.members.select { |i| i <= n }
  total = 0
  gps.each_with_index do |g, index|
    total += [0, 1].include?(index % 4) ? partition(n-g) : -partition(n-g)
  end
  @memoize[n] = total
#  puts @pn.members.inspect
#  @memoize[n] = gps.inject(0) do |sum, g|
#    puts "#{n-g} -> #{@memoize[n - g]}"
#    #sum + @memoize[n - g]
#    sum + partition(n-g)
#  end
end

assert_equal [1, 2, 5, 7, 12, 15, 22], @pn.all_below(25)
assert_equal [1, 2, 3, 5, 7, 11, 15, 22, 30, 42], (1..10).map { |i| partition(i) }

i = 1
while(partition(i) % 1000000 != 0)
  puts "calculating for #{i}" if i % 100 == 0
  i += 1
end
puts "#{i}, #{partition(i)}"