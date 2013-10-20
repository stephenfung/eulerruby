def same_characters(p, q)
  p.to_s.chars.to_a.sort == q.to_s.chars.to_a.sort
end

def solve
  n = 10
  while(true)
    return n if matches(n)
    n += 1
  end
end

def matches(n)
  return if n.to_s[0] != "1"
  (2..6).all? { |m| same_characters(n, n*m) }
end

puts solve