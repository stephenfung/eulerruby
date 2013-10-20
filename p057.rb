@repeated = {}
@repeated[1] = Rational(2, 1)
(2..1000).each do |i|
  @repeated[i] = Rational(2, 1) + Rational(1, 1) / @repeated[i-1]
end

def numerator_more_digits(r)
  r.numerator.to_s.length > r.denominator.to_s.length
end

puts (1..1000).map{ |i| Rational(1,1) + 1 / @repeated[i] }.select { |r| numerator_more_digits(r) }.count
