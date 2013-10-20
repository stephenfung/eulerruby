require './lib/prime_factorizer.rb'
@b = (2..100)
@pf = PrimeFactorizer.new

def new_distinct_terms(max_root)
  return @b.count if max_root == 1
  new_exponents = @b.to_a.map { |e| e * max_root }
  (max_root - 1).downto(1).each { |n| new_exponents -= @b.to_a.map { |e| e * n } }
  new_exponents.length
end


distinct_terms = 0
(2..100).each do |a|
  max_root = @pf.max_root_integer(a)
  distinct_terms += new_distinct_terms(max_root)
end

puts distinct_terms