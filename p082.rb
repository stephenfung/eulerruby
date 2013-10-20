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

  #Dynamic programming algorithm.  distances[i][j] = the cheapest way to get from the leftmost column to (i, j).

  distances = []
  height.times.each { distances << [] }
  for j in 0...width
    #Get the min cost that ends in a right-move
    for i in 0...height
      distances[i][j] = ((distances[i][j-1] if j > 0) || 0) + matrix[i][j]
    end

    #Now check if moving up/down from a neighbour would've helped.  Keep trying to improve things
    #similar to how bubble sort works.
    changed = true
    while(changed)
      changed = false
      for i in 0...height
        if i > 0 and distances[i-1][j] + matrix[i][j] < distances[i][j]
          distances[i][j] = distances[i-1][j] + matrix[i][j]
          changed = true
        end
        if i < height - 1 and distances[i+1][j] + matrix[i][j] < distances[i][j]
          distances[i][j] = distances[i+1][j] + matrix[i][j]
          changed = true
        end
      end
    end

  end

  distances
end

test_matrix = [[131, 673, 234, 103, 18], [201, 96, 342, 965, 150], [630, 803, 746, 422, 111], [537, 699, 497, 121, 956], [805, 732, 524, 37, 331]]

assert_equal 994, find_distances(test_matrix).map { |row| row.last }.min

matrix = load_matrix("data/matrix.txt")

puts find_distances(matrix).map { |row| row.last }.min
