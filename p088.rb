require './lib/functions'
require './lib/prime_factorizer'
require 'set'

@pf = PrimeFactorizer.new

@min_product_sum = []
@min_unfilled_k = 2
@max_k = 12000
product = 4

def get_score(factors, product = nil)
  product ||= factors.inject(1, &:*)
  factors.length + product - factors.inject(0, &:+)
end

def process(factorization, product, visited=nil)
  #If we've already visited this factorization, then skip now
  return if visited && visited.include?(factorization)

  s = get_score(factorization)
  #Our score can't get any higher by combining factors, so give up if the best possible score is already too small to be useful
  return if @min_unfilled_k > s

  visited ||= Set.new

  unless @min_product_sum[s] || s > @max_k  #Only record it if the score falls within the maximum
    @min_product_sum[s] ||= product
    update_min_unfilled_k
  end

  visited.add(factorization)

  combine_pairs(factorization).each { |new_factorization| process(new_factorization, product, visited) }

end

def combine_pairs(list)
  results = []
  for i in 0...list.length
    for j in (i+1)...list.length
      v = ((0...list.length).reject { |n| [i, j].include?(n) }.map { |n| list[n] } << (list[i] * list[j])).sort
      results << v
    end
  end
  results
end

def update_min_unfilled_k
  i = @min_unfilled_k
  while true
    unless @min_product_sum[i]
      @min_unfilled_k = i
      return
    end
    i += 1
  end
end

assert_equal(get_score([2, 3]), 3)
assert_equal(get_score([2, 4]), 4)
assert_equal(get_score([2, 2, 2]), 5)

assert_equal(combine_pairs([2, 2]), [[4]])
assert_equal(combine_pairs([2, 3, 5]), [[5, 6], [3, 10], [2, 15] ])

while(@min_unfilled_k < @max_k)
  #puts "Processing #{product}"
  factorization = @pf.factorize(product)
  process(factorization, product)
  product += 1
end

puts @min_product_sum.inspect

puts @min_product_sum.uniq.compact.inspect

puts @min_product_sum.uniq.compact.inject(0, &:+)