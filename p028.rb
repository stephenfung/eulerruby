require './lib/functions'

#def spiral_corners(n)
#  return 1 if n == 1
#  raise ArgumentError("Not implemented") if n % 2 == 0 || n < 1
#  #n**2 + (n**2 - (n-1)) + (n**2 - 2(n-1)) + (n**2 - 3(n-1))
#  (4 * n**2) - 6*n + 6
#end

puts (1..1001).select{|x| x % 2 == 1}.inject(0){ |acc, i| acc + spiral_corners(i).inject(0, &:+) }