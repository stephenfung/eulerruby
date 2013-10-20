#9^5 = 59049
#7 digit numbers won't work because
#999999 --> 7 * 59049 = 413343 < 1000000
#For 6 digit numbers, the largest ones to consider are 9^5 * 6 = 354294

@cache = "1234567890".chars.inject({}){|h, c| h[c] = (c.to_i ** 5); h}

def sum_of_fifth_powers(n)
  n.to_s.chars.inject(0){|acc, c| acc + @cache[c]}
end

puts (2..354294).select{|n| n == sum_of_fifth_powers(n)}.inject(0, &:+)