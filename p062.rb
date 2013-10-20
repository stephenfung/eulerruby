def solve(num_digits)
  #Find the range of integers whose cubes may be num_digits
  from = (10 ** ((num_digits - 1) * 0.33)).to_i
  to = (10 ** (num_digits * 0.34)).to_i


  (from..to).map { |n| n ** 3 }.select { |n| (10**(num_digits-1)..10**num_digits).include? n }.group_by { |n| n.to_s.chars.sort.join }.select { |g, values| values.count == 5 }
end

for num_digits in 2..12
  a = solve num_digits
  break if a.any?
end
puts a.inspect