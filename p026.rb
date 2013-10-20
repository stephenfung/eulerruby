require './lib/prime_factorizer'

def length_of_repeating_part(n)
  first_time_mods = { }

  modulus = 1
  exponent = 0
  while true
    return 0 if modulus == 0
    #puts first_time_mods.inspect, modulus, exponent
    if(first_time_mods.include? modulus)
      return exponent - first_time_mods[modulus]
    else
      first_time_mods[modulus] = exponent
      exponent += 1
      modulus = (modulus * 10) % n
    end
  end
end

puts (1...1000).max_by { |n| length_of_repeating_part(n) }