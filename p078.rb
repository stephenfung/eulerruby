require './lib/functions'

#Dynamic programming algorithm
#Let x[i, j] be the number of ways you can write i as a sum of integers each <= j

x = []

i = 1
while true #loop on i
  x << []
  for j in (1..i)
    #All the ways of writing i without using j
    if j == 1
      x.last << 1
    else
      x.last << (x.last.last + (i == j ? 1 : 0) + (i-j > 0 ? x[i-j-1][ [j, i-j].min - 1] : 0)) % 1000000
    end
  end
  puts "#{i} #{x.last.last}"
  if x.last.last % 1000000 == 0
    puts "#{i}, #{x.last.last}"
    exit
  end

#  if i > 100
#    break
#  end
  i += 1
end
#puts (1..100).map { |i| [i, x[[i, i]]] }.inspect
