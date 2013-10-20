require './lib/functions'

#(1..10).map { |n| pentagonal_number(n) }.tap { |k| puts k.inspect }

#We want the smallest pentagonal number p such that p = P_j - P_k for some pentagonal numbers P_j and P_k

#P_n - P_n-1 = 3n - 2
#k = 3n - 2 => n = (k+2)/3

@pentagonal_number_tester = PentagonalNumbers.new

pa = 1
window = [5]
window_sequence = 2
while true
  #Update the window of possible second terms
  while !window.any? || (window_sequence * 3 + 2 <= pa)
    window_sequence += 1
    window << pentagonal_number(window_sequence)
  end

  puts "testing #{pa}"

  pentagonal_sums = window.select { |w| @pentagonal_number_tester.test(pa + w) }
  double_sums = pentagonal_sums.select { |w| @pentagonal_number_tester.test(w + pa + w) }
  if double_sums.any?
    puts "GOTCHA!!"
    puts "#{pa} #{pentagonal_sums.inspect} #{double_sums.inspect} "
    puts double_sums.inspect
    break
  end

  #Didn't find any.  Remove one from the window and test that one
  pa = window.shift
end

#def pentagonal_differences(n)
#  #Find the largest possible pentagonal numbers that could subtract to something like this
#  #Only consider numbers up to floor (n+2)/3
#  #Suppose j > k
#  max_j = ((n+2)/3).to_i
#  all_possibilities = []
#  (1..max_j).each do |j|
#    (1...j).each do |k|
#      if (pentagonal_number(j) - pentagonal_number(k)) == n
#        all_possibilities << [pentagonal_number(j), pentagonal_number(k)]
#      end
#    end
#  end
#  return all_possibilities
#end
#
#def pentagonal_sums(n)
#  sums = []
#  (1..n).each do |a|
#    (a+1..n).each do |b|
#      pa, pb = pentagonal_number(a), pentagonal_number(b)
#      if @pentagonal_number_tester.test(pa + pb)
#        sums << [pa, pb, pa + pb]
#        if @pentagonal_number_tester.test(pb + pa + pb)
#          puts "#{pa}, #{pb}, #{pa + pb}, #{pa + pb + pb}"
#          raise ArgumentError("HAHA!")
#        end
#      end
#    end
#  end
#  sums
#end

def pentagonal_sums(a)
  pa = pentagonal_number(a)
  sums = []
  b = a + 1
  #p_(b+1) - p_b = 3b+2, so that's the biggest we need to test
  while (3*b + 2) <= pa
    pb = pentagonal_number(b)
    if (@pentagonal_number_tester.test(pa + pb))
      sums << [pa, pb, pa + pb]
    end
    b += 1
  end
  sums
end

a = 1
while true
  mysums = pentagonal_sums(a)
  matches = mysums.select { |pa, pb, pc| puts "#{pa} + #{pb} = #{pc}"; @pentagonal_number_tester.test(pb + pc) }
  if(matches.any?)
    puts "GOTCHA!!"
    puts matches.inspect
    break
  end
  a += 1
end


#puts pentagonal_sums(10000).inspect
#
#(1..10).map { |n| pentagonal_number(n) }.select { |n| pentagonal_differences(n).any? }.tap { |t| puts t.inspect }
#
#
#n = 1
#while true
#  #Test if this can be a pentagonal difference
#  d = pentagonal_differences(pentagonal_number(n))
#  puts d.inspect
#  n += 1
#end
#
#pns = (1..10000).map { |n| pentagonal_number(n) }
#puts pns.inspect
#
#pns.product(pns).select { |a, b| pentagonal_number_tester.test(a+b) && pentagonal_number_tester.test(a-b) }.tap { |t| puts t.inspect }