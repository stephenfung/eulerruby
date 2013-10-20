require 'set'

def has_no_zeroes(n)
  s = n.to_s

end

def has_unique_digits(n)
  s = n.to_s
  s.chars.to_a.uniq.count == n.to_s.length
end

def get_remaining_digits(n)
  (Set.new("123456789".chars) - Set.new(n.to_s.chars)).to_a
end

#Smallest - 4 digits (3 digits won't do because ### * ### > ###)
#Largest - 4 digits (5 digits won't do because # * ### < ##### and ## * ## < #####)
all = (1000..9999).reject{|n| n.to_s.chars.include?("0")}.select{|n| has_unique_digits(n)}.select{ |n|
  #For 4-digit numbers, the multiplicands must be (1, 4) digits or (2, 3) digits.
  #Since we don't care about the ordering, we can just assume we partition the digits as # * #### or ## * ###
  get_remaining_digits(n).permutation.any? { |p|
    if p[0, 2].join.to_i * p[2,3].join.to_i == n
      puts "#{n} = #{p[0,2].join} x #{p[2,3].join}"
      true
    elsif p[0, 1].join.to_i * p[1,4].join.to_i == n
      puts "#{n} = #{p[0,1].join} x #{p[1,4].join}"
      true
    end
  }
}

puts all.inject(0, &:+)