numbers = []
numbers << [75,]
numbers << [95, 64,]
numbers << [17, 47, 82,]
numbers << [18, 35, 87, 10,]
numbers << [20, 4, 82, 47, 65,]
numbers << [19, 1, 23, 75, 3, 34,]
numbers << [88, 2, 77, 73, 7, 63, 67,]
numbers << [99, 65, 4, 28, 6, 16, 70, 92,]
numbers << [41, 41, 26, 56, 83, 40, 80, 70, 33,]
numbers << [41, 48, 72, 33, 47, 32, 37, 16, 94, 29,]
numbers << [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14,]
numbers << [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57,]
numbers << [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48,]
numbers << [63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31,]
numbers << [4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23,]

max_numbers = []
#Dynamic programming solution
(0...numbers.length).each do |row|
  new_max_numbers = []
  if(row == 0)
    new_max_numbers << numbers[row][0]
  else
    #The best way to get here is the best way to get to the adjacent blocks in the above row + this
    new_max_numbers << max_numbers.last[0] + numbers[row][0]
    (1...row).each do |i|
      new_max_numbers << [max_numbers.last[i-1] + numbers[row][i], max_numbers.last[i] + numbers[row][i]].max
    end
    new_max_numbers << max_numbers.last.last + numbers[row].last
  end
  max_numbers << new_max_numbers
end

puts max_numbers.last.max