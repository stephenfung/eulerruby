require './lib/functions'
require 'set'

#It'll be a 10-digit string iff the number 10 is one of the external nodes
#Total can be from [(1+2+3+...+10) * 2 - (1+2+3+4+5)  ] / 5
#to                [(1+2+3+...+10) * 2 - (6+7+8+9+10) ] / 5
#so... (110 - 18) / 5 to (110 - 40) / 5 = one of { 14, 15, 16, 17, 18 }
#The sum of the external numbers must be divisible by 5

#Try 6,7,8,9,10 first and work our way down
#Try all permutations of 6,7,8,9,10

def is_valid(external, internal)
  [[0, 0, 1], [1, 1, 2], [2, 2, 3], [3, 3, 4], [4, 4, 0]].map { |a, b, c| external[a] + internal[b] + internal[c] }.uniq.count == 1
end

def to_string(external, internal)
  [[0, 0, 1], [1, 1, 2], [2, 2, 3], [3, 3, 4], [4, 4, 0]].map { |a, b, c| external[a].to_s + internal[b].to_s + internal[c].to_s }.join
end

ordered_permutations([7, 8, 9, 10]).map { |p| [6] + p }.each do |ext| #Restrict the lowest number to be first
  internals = ordered_permutations((Set.new(1..10) - Set.new(ext)).to_a)
  puts internals.select { |int| is_valid(ext, int) }.map { |int| to_string(ext, int) }
end

#Outputs
#6357528249411013
#6531031914842725
#The latter one is bigger, use that one