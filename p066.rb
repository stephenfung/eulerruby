require './lib/continued_fractions'
require './lib/functions'

def minimal(d)
  return nil if is_square(d)
  cf = ContinuedFraction.new_for_square_root(d)
  i = 1
  while true
    f = cf.convergent_fraction(i)
    x, y = f.numerator, f.denominator
    return x if x**2 - d * y**2 == 1
    i += 1
  end
end

assert_equal [3, 2, 9, 5, 8, 649], [2, 3, 5, 6, 7, 13].map { |d| minimal(d) }

assert_equal 5, (1..7).map { |d| [d, minimal(d) || 0] }.max_by { |d, x| x }[0]

assert_equal 661, (1..1000).map { |d| [d, minimal(d) || 0] }.max_by { |d, x| x }[0]
