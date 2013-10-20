require 'matrix'

l = 21
w = 21
m = []
l.times{m << [0]*w}

(0...l).each do |i|
  (0...w).each do |j|
    if [i,j] == [0, 0]
      m[i][j] = 1
    else
      m[i][j] = 0
      m[i][j] += m[i-1][j] if i > 0
      m[i][j] += m[i][j-1] if j > 0
    end
  end
end

puts m.last.last