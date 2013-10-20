require './lib/functions'

TARGET = 2000000

def rectangles(l, w)
  (l) * (l+1) / 2 * (w) * (w+1) / 2
end

def search(p1, target=TARGET)
  lower = Math.sqrt(target * 4 / p1 / (p1+1)).floor
  (-1..1).map { |i| [p1, lower + i, rectangles(p1, lower+i)] }.min_by { |x, y, t| (target - t).abs }
end

x, y, rectangles = (1..1999).map { |i| search(i) }.min_by { |x, y, t| (TARGET - t).abs }
puts x * y