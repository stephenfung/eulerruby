require './lib/functions'

#testers = [TriangleNumbers.new, SquareNumbers.new, PentagonalNumbers.new]
testers = [TriangleNumbers.new, SquareNumbers.new, PentagonalNumbers.new, HexagonalNumbers.new, HeptagonalNumbers.new, OctagonalNumbers.new].reverse

#Returns a list of list of digit parts e.g. [[24, 46, 23], [11, 77, 25]] that has this cyclic property for the given maps and starts with starting_digits
def find_workable(maps, previous_digits)
  #If there's no criteria to meet, then what we have already will work
  return [previous_digits] if maps.empty?

  #Go through the criteria
  matches = []
  maps.each do |m|
    (m[previous_digits.last] || []).each do |next_two_digits|
      matches += find_workable(maps - [m], previous_digits + [next_two_digits])#.map { |s| previous_digits + s }
    end
  end
  #puts "RETURN -- #{maps.count} maps, #{previous_digits.inspect}, #{matches}"
  matches
end

passes = testers.map { |tester| (1000...10000).select { |n| tester.test(n) } }
maps = testers.map do |tester|
  (1000...10000).select { |n| tester.test(n) }.inject({}) do |h, n|
    pre = n.to_s[0, 2].to_i
    post = n.to_s[2, 2].to_i
    h[pre] = (h[pre] || []) << post
    h
  end
end

#Start with an octagonal number, since there are the fewest of those
results = []
for n in passes.first
  results += find_workable(maps - [maps.first], [n.to_s[-2, 2].to_i]).select { |s| s.last == n / 100 }
end

puts results.inspect
answer = results.first
puts answer.inject(0, &:+) * 101