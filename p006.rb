range = (1..100)
sum_of_squares = range.map { |x| x ** 2 }.inject(0, &:+)
square_of_sum = (range.inject(0, &:+)) ** 2

puts square_of_sum - sum_of_squares