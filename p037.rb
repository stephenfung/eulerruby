require './lib/prime_factorizer'

@pf = PrimeFactorizer.new
def is_left_truncatable(n)
  return false unless @pf.is_prime(n)
  sn = n.to_s
  len = sn.length
  #Test left truncatable
  return false unless (1...len).all? { |i| @pf.is_prime(sn[i,len].to_i) }
  return true
end

@all_right_truncatable = {1 => [2, 3, 5, 7]}
def find_all_right_truncatable_fixed_digits(digits)
  return @all_right_truncatable[digits] if @all_right_truncatable.include?(digits)
  #Test prefixes of the right_truncatable ones from last time
  @all_right_truncatable[digits] = []
  @all_right_truncatable[digits - 1].each do |n|
    @all_right_truncatable[digits] += [1, 3, 5, 7, 9].map{|p| n * 10 + p }.select{|p| @pf.is_prime(p) }
  end
end

def find_all_right_truncatable
  i = 1
  while @all_right_truncatable[i].any?
    find_all_right_truncatable_fixed_digits(i += 1)
  end
end

find_all_right_truncatable
puts @all_right_truncatable.inspect
bitruncatable = @all_right_truncatable.values.flatten.select { |n| is_left_truncatable(n) }.select { |n| n >= 10 }
puts bitruncatable.inspect
puts bitruncatable.inject(0, &:+)