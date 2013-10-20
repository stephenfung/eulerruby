require './lib/functions'

@cached_terminal = { 1 => 1, 89 => 89 }

def digital_sum_of_squares(n)
  n.to_s.chars.inject(0) { |sum, c| sum + c.to_i ** 2 }
end

def find_terminating_point_cache(n)
  to_update = []
  while(!@cached_terminal.include?(n) )
    to_update << n
    n = digital_sum_of_squares(n)
  end

  to_update.each do |i|
    @cached_terminal[i] = @cached_terminal[n]
  end

  return @cached_terminal[n]
end

def find_terminating_point_brute(n)
  while(n != 1 && n != 89)
    n = digital_sum_of_squares(n)
  end

  return n
end



count1 = 0
for i in 1...10**7
  puts i if i % 1000 == 0
  count1 += 1 if find_terminating_point_cache(i) == 89
end
puts count1
#
#puts "#{count1}, #{count2}, #{count3}"
#
#assert_equal(count1, count2)
#assert_equal(count2, count3)