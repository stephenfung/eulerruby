require './lib/functions'

names = parse_file("data/names.txt")

puts names.sort.each_with_index.inject(0){|acc, name_with_index| acc + letter_score(name_with_index.first) * (name_with_index.last + 1)}