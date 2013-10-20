#9! = 362880
#8 digit numbers won't work because
#sum of digits <= 9! * 8 = 2903040 < n
#7 digit numbers; the largest to consider is 2540160

@cache = (0..9).inject({}){|h, i| h[i.to_s] = (i == 0 ? 1 : h[(i-1).to_s] * i); h }

def sum_of_factorials(n)
  n.to_s.chars.inject(0){|acc, c| acc + @cache[c]}
end

k = (3..2540160).select{|n| n == sum_of_factorials(n)}
puts k.inspect
puts k.inject(0, &:+)