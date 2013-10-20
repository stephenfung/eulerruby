def parse_file
  numbers = []
  File.open("data/triangle.txt", "r") do |file|
    while(line = file.gets)
      numbers << line.split(" ").map { |s| s.to_i }
    end
  end
  numbers
end

numbers = parse_file

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