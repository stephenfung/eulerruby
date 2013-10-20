@memory = { 1 => 1}

def next_iteration(n)
  n % 2 == 0 ? n/2 : 3*n + 1
end

def length(n)
  stack = []
  stack.push n

  while stack.any? do
    #Check if we know the last element in the stack
    if @memory.include? stack.last
      current_length = @memory[stack.pop]

      #Unwind the stack and learn anything above there in the stack
      while stack.any? do
        @memory[stack.pop] = (current_length += 1)
      end
    else
      #Go deeper into our learning
      stack.push next_iteration(stack.last)
    end
  end

  @memory[n]
end

puts (1...1000000).max_by{|n| length(n)}
