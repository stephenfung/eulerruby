require './lib/functions'

class Integer < Numeric
  MAP_HUNDREDS = { 0 => '', 1 => 'C', 2 => 'CC', 3 => 'CCC', 4 => 'CD', 5 => 'D', 6 => 'DC', 7 => 'DCC', 8 => 'DCCC', 9 => 'CM', }
  MAP_TENS = { 0 => '', 1 => 'X', 2 => 'XX', 3 => 'XXX', 4 => 'XL', 5 => 'L', 6 => 'LX', 7 => 'LXX', 8 => 'LXXX', 9 => 'XC', }
  MAP_ONES = { 0 => '', 1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV', 5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX', }

  def to_roman
    rv = ""
    #Put an "M" for each thousand
    rv += "M" * (self / 1000)
    #Look at the hundreds digit
    rv += MAP_HUNDREDS[(self % 1000 / 100)]
    rv += MAP_TENS[(self % 100 / 10)]
    rv += MAP_ONES[self % 10]
    rv
  end
end

class String
  MAP = {'I' => 1, 'V'=> 5, 'X'=> 10, 'L'=> 50, 'C'=> 100, 'D'=> 500, 'M'=> 1000}

  def char_to_value(c)
    MAP[c] || 0
  end

  def roman_to_int
    #Go through the numbers in reverse
    max_seen = nil
    sum = 0
    self.reverse.chars.each do |digit|
      val = char_to_value(digit)
      if(!max_seen || val >= max_seen)
        sum += val
      else
        sum -= val
      end
      max_seen = val if !max_seen || max_seen < val
    end
    sum
  end
end

def savings(s)
  s.length - s.roman_to_int.to_roman.length
end

def look(s)
  puts "#{s} = #{s.roman_to_int} --> #{s.roman_to_int.to_roman} for a savings of #{savings(s)}"
end

assert_equal('IX'.roman_to_int, 9)
assert_equal('MCMXC'.roman_to_int, 1990)
assert_equal('XXVIIII'.roman_to_int, 29)
assert_equal('XXIVIII'.roman_to_int, 27)

assert_equal(8.to_roman, 'VIII')
assert_equal(9.to_roman, 'IX')
assert_equal(1990.to_roman, 'MCMXC')

assert_equal(savings('VIIII'), 3)

total_savings = 0
File.open('data/roman.txt', 'r') do |file|
  while(line = file.gets)
    line.strip!
    look(line)
    total_savings += savings(line)
  end
end

puts total_savings