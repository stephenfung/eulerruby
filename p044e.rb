require './lib/functions'

#(1..10).map { |n| pentagonal_number(n) }.tap { |k| puts k.inspect }

#We want the smallest pentagonal number p such that p = P_j - P_k for some pentagonal numbers P_j and P_k

#P_n - P_n-1 = 3n - 2
#k = 3n - 2 => n = (k+2)/3

@pentagonal_number_tester = PentagonalNumbers.new

def get_differences(a)
  pa = pentagonal_number(a)
  pa2 = pa * 2
  k = 0
  matches = []
  while true
    #See if k is too big
    if pentagonal_number(a + k + 1) > pa2
      #puts "testing #{a}, #{pa} -- matches #{matches.inspect}"
      return matches
    end

    #See if we can find a match of the form pa = pb - p_(b-k) = k(6b - 3k - 1) / 2 = 3kb - pk - k
    pk = pentagonal_number(k)
    #3kb = pa + pk + k
    t = pa + pk + k
    if (t % (3 * k)) == 0
      b = t / 3 / k
      pb = pentagonal_number(b)
      #raise Exception("TEST FAIL") unless @pentagonal_number_tester.test(pb)
      pbk = pentagonal_number(b-k)
      #raise Exception("TEST FAIL") unless @pentagonal_number_tester.test(pbk)
      raise Exception("FAIL") unless pa + pbk == pb
      matches << [pa, pentagonal_number(b-k), pb]
      puts "MATCH #{a} #{b-k} #{b}"
      if @pentagonal_number_tester.test(pbk + pb)# || @pentagonal_number_tester.test(pa + pb)
        puts "DONE!!" + [a, k, b, pa, pbk, pb].inspect
        raise EOFError.new("DONE!")
        return
      end
    end
    k += 1
  end
end

a = 1
while true
  get_differences(a)
  a += 1
end
#
#puts pb = pentagonal_number(1020)
#puts pa = pentagonal_number(255)
#puts pc = pentagonal_number(2167)
#puts pd = pentagonal_number(1912)
#if d = @pentagonal_number_tester.test(pa + pc)
#  puts pd = pentagonal_number(d)
#end
#if d = @pentagonal_number_tester.test(pb + pc)
#  puts pd = pentagonal_number(d)
#end
