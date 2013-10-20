require './lib/functions'
require './lib/prime_factorizer'

tn = TriangleNumbers.new
words = parse_file("data/words.txt")

triangle_words = words.select { |w| tn.is_triangle_number(letter_score(w)) }
puts triangle_words.length #162