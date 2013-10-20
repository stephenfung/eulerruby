require './lib/functions'

def can_represent_squares(c1, c2)
  return false unless can_represent(0, 1, c1, c2)
  return false unless can_represent(0, 4, c1, c2)
  return false unless can_represent(0, 9, c1, c2)
  return false unless can_represent(1, 6, c1, c2)
  return false unless can_represent(2, 5, c1, c2)
  return false unless can_represent(3, 6, c1, c2)
  return false unless can_represent(4, 9, c1, c2)
  return false unless can_represent(6, 4, c1, c2)
  return false unless can_represent(8, 1, c1, c2)
  true
end

def can_represent(d1, d2, c1, c2)
  one_can_represent(d1, c1) && one_can_represent(d2, c2) || one_can_represent(d1, c2) && one_can_represent(d2, c1)
end

def one_can_represent(d1, c1)
  [6, 9].include?(d1) ? c1.include?(6) || c1.include?(9) : c1.include?(d1)
end

assert_equal(true, can_represent_squares([0, 5, 6, 7, 8, 9], [1, 2, 3, 4, 8, 9]))
assert_equal(false, can_represent_squares([0, 5, 6, 7, 8, 9], [1, 2, 3, 4, 8, 5]))

assert_equal(210, (0..9).to_a.all_subsets_of_size(6).count)

all_dice = (0..9).to_a.all_subsets_of_size(6)

count = 0
for i in 0...210
  for j in i...210
    count += 1 if can_represent_squares(all_dice[i], all_dice[j])
  end
end
#
#count = 0
#for c1 in (0..9).to_a.all_subsets_of_size(6)
#  for c2 in (0..9).to_a.all_subsets_of_size(6)
#    count += 1 if can_represent_squares(c1, c2)
#  end
#end

puts count