require './lib/functions'
require 'set'

def load_matrix(filename)
  rows = []
  File.open(filename, "r") do |file|
    rows = file.readlines.map { |line| line.split(",").map { |w| w.to_i } }
  end
  rows
end


def find_distances(matrix)
  #Dijkstra's algorithm starting from the top left
  height = matrix.length
  width = matrix[0].length

  #Current node -- start at the top left and set the weight to the value of that number
  distances = { [0, 0] =>  matrix[0][0] }
  unvisited = { [0, 0] =>  matrix[0][0] }
  visited = Set.new #Ain't seen anything yet

  while(visited.count < height * width)
    #Find the next one to visit
    #location, current_distance = distances.reject{ |location| visited.include?(location) }.min_by { |location, value| value }
    location, current_distance = unvisited.min_by { |location, value| value }
    i, j = location

    #Now check all its neighbours
    update = lambda do |x, y, old_distance|
      unless x < 0 || y < 0 || x >= height || y >= width
        distances[[x, y]] = [distances[[x, y]], old_distance + matrix[x][y]].compact.min
        unless visited.include?([x, y])
          unvisited[[x, y]] = distances[[x, y]]
        end
      end
    end

    update.call(i-1, j, current_distance)
    update.call(i+1, j, current_distance)
    update.call(i, j-1, current_distance)
    update.call(i, j+1, current_distance)

    visited.add([i, j])
    unvisited.delete([i, j])
  end

  distances
end


test_matrix = [[131, 673, 234, 103, 18], [201, 96, 342, 965, 150], [630, 803, 746, 422, 111], [537, 699, 497, 121, 956], [805, 732, 524, 37, 331]]

assert_equal 2297, find_distances(test_matrix)[[4, 4]]

matrix = load_matrix("data/matrix.txt")

assert_equal 425185, find_distances(matrix)[[79, 79]]
