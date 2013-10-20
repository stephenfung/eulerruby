fib = [1, 2]
while fib.last <= 4000000
  fib << fib[-1] + fib[-2]
end
fib.pop
puts fib.select{|x| x % 2 == 0}.inject(&:+)