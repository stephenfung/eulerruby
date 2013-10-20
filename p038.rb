require './lib/functions'

def is_concatenated_product_of(s, n)
  remaining = s
  multiple = 1
  while(remaining.length > 0)
    s = (n * multiple).to_s
    if remaining.start_with?(s)
      remaining = remaining[s.length, remaining.length]
      multiple += 1
    else
      return false
    end
  end
  return true
end

def is_concatenated_product?(s)
  (1..4).each do |k|
    #Grab the first k digits
    candidate = s[0, k]
    return true if is_concatenated_product_of(s, candidate.to_i)
  end
  return false
end

#puts is_concatenated_product_of("192384576", 19)
#puts is_concatenated_product_of("192384577", 192)
#puts is_concatenated_product?("192384576")

puts ordered_permutations((1..9).to_a.reverse).map { |a| a.join }.find { |s| is_concatenated_product?(s) }.inspect


