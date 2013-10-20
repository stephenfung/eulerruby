require './lib/functions'

def load_matrix(filename)
  rows = []
  File.open(filename, "r") do |file|
    rows = file.readlines.map { |line| line.split(",").map { |w| w.to_i } }
  end
  rows
end

def find_distances(matrix)
  height = matrix.length
  width = matrix[0].length

  distances = []
  for i in 0...height
    distances << []
    for j in 0...width
      distances.last << ([(distances[i-1][j] if i > 0), (distances[i][j-1] if j > 0)].compact.min || 0) + matrix[i][j]
    end
  end

  distances
end

test_matrix = [[131, 673, 234, 103, 18], [201, 96, 342, 965, 150], [630, 803, 746, 422, 111], [537, 699, 497, 121, 956], [805, 732, 524, 37, 331]]

assert_equal 2427, find_distances(test_matrix).last.last

matrix = load_matrix("data/matrix.txt")

assert_equal 427337, find_distances(matrix).last.last