ten_ten = 10 ** 10
sum = 0
(1..1000).each do |n|
  k = 1
  n.times do
    k *= n
    k = k % ten_ten
  end
  sum += k
  sum %= ten_ten
end

puts sum