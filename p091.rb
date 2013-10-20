require './lib/functions'
require 'matrix'

def is_valid_triangle(p, q)
  #As long as all the points are distinct, they can form a triangle
  !(p == q || p == [0, 0] || q == [0, 0])
end

def has_right_angle(p, q)
  return false unless is_valid_triangle(p, q)

  return true if is_right_angle2(p, q)
  return true if is_right_angle2(p, [q[0] - p[0], q[1] - p[1]])
  return true if is_right_angle2(q, [q[0] - p[0], q[1] - p[1]])

  #ov = Vector[0, 0]
  #pv = Vector[*p]
  #qv = Vector[*q]
  #
  ##Check if PO _|_ OQ
  #return true if is_right_angle(ov - pv, qv - ov)
  ##Check if OP _|_ PQ
  #return true if is_right_angle(pv - ov, qv - pv)
  ##Check if OQ _|_ QP
  #return true if is_right_angle(qv - ov, pv - qv)

  return false
end

def is_right_angle2(v1, v2)
  (v1[0] * v2[0] + v1[1] * v2[1]) == 0
end

def is_right_angle(v1, v2)
  #It's a right angle iff the dot product is zero
  #l1[0] * l2[0] + l1[1] + l2[1] == 0
  v1.inner_product(v2) == 0
end

assert_equal(true, has_right_angle([0, 1], [1, 0]))
assert_equal(false, has_right_angle([0, 3], [1, 1]))

def count_triangles(max_dimension)
  count = 0
  for x1 in 0..max_dimension
    puts "Checking x1 = #{x1}"
    for y1 in 0..max_dimension
      for x2 in 0..max_dimension
        for y2 in 0..max_dimension
          count += 1 if has_right_angle([x1, y1], [x2, y2])
        end
      end
    end
  end
  #We're going to count every triangle twice (OPQ and OQP)
  count / 2
end

assert_equal(14, count_triangles(2))
puts count_triangles(50)