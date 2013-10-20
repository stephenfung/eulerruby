#Fast lookup to determine if a number is a square
sqrts = (1..1000).inject({}) { |h, i| h[i*i] = i; h }

#If a^2 + b^2 = c^2, assume a < b
#Then in order for a + b + c <= 1000, then b < 500

triplets = []

(3...500).each do |a|
  (a+1...500).each do |b|
    k = a*a + b*b
    if sqrts.include?(k)
      triplets << [a, b, sqrts[k]]
    end
  end
end

puts triplets.group_by{ |a, b, c| a + b + c }.max_by { |g, triplets| triplets.count }.inspect
