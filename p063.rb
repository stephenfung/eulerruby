#10^(n-1) <= k^n < 10^(n)
#Can only work if k < 10

count = 0
n = 1
begin
  found = false
  for i in (1..9)
    if i ** n >= 10 ** (n-1)
      count += 1
      found = true
    end
  end
  puts "#{n}, #{count}"
  n += 1
end while found

puts count