require './lib/functions'

def shortest_distance_is_integer(a, b, c)
  #assume a <= b <= c
  is_square(c ** 2 + (a+b)**2)
end

assert_equal true, shortest_distance_is_integer(3, 5, 6)
assert_equal true, shortest_distance_is_integer(4, 4, 6)
assert_equal false, shortest_distance_is_integer(3, 6, 6)

count = 0
for m in 1..10000
  for i in 1..m
    for j in 1..i
      count += 1 if shortest_distance_is_integer(i, j, m)
    end
  end
  puts "#{m} has count #{count}"
  return if count > 1000000
end