require './lib/functions'

def is_lychrel(n)
  50.times do
    n = n + n.to_s.reverse.to_i
    puts n
    return false if is_palindrome(n)
  end
  puts "lychrel!"
  return true
end
(1...10000).select{|n| is_lychrel(n)}.count.tap { |t| puts t }

#puts is_lychrel(196)