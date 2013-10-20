require './lib/functions'

#Dynamic programming algorithm
#Let x[i, j] be the number of ways you can write i as a sum of integers each <= j

max = 100

x = Hash.new(0)

for i in 1..max
  for j in 1..i
    if j == 1
      x[[i,j]] = 1
    else
      #All the ways of writing it without using the new largest number
      x[[i,j]] = x[[i, j-1]]
      #Use the number j once, twice, three times, k times...
      k = 1
      while j * k <= i
        if j * k == i
          x[[i, j]] = x[[i, j]] + 1
        else
          x[[i, j]] = x[[i, j]] + x[[i - j*k, [j-1, i - j*k].min]]
        end
        k += 1
      end
    end
  end
end

assert_equal 6, x[[5, 4]]
assert_equal 190569291, x[[100, 99]]