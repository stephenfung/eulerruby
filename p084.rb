require './lib/functions'

class Monopoly

  def initialize
    @consecutive_doubles = 0
  end

  NEXT_RAILROAD = { 7 => 15, 22 => 25, 36 => 5 }
  NEXT_UTILITY = { 7 => 12, 22 => 28, 36 => 12 }

  GO = 0
  JAIL = 10
  G2J = 30
  C1 = 11
  E3 = 24
  H2 = 39
  R1 = 5
  NUM_SQUARES = 40

  def take_turn(start_square, roll=nil)
    roll ||= 2.times.map { rand(4) + 1}
    #Check for consecutive doubles
    if roll.all_same?
      @consecutive_doubles += 1
    else
      @consecutive_doubles = 0
    end
    #Go to jail immediately on 3 consecutive doubles
    if @consecutive_doubles >= 3
      @consecutive_doubles = 0
      return JAIL
    end

    temporary_square = (start_square + roll.inject(&:+)) % NUM_SQUARES

    #Handle all the special cases that can force us to go somewhere
    if is_community_chest(temporary_square)
      return community_chest_move(temporary_square)
    elsif is_chance(temporary_square)
      return chance_move(temporary_square)
    elsif temporary_square == G2J
      return JAIL
    end

    #We stay on that square
    return temporary_square
  end

  def community_chest_move(square)
    case rand(16)
      when 0
        return GO
      when 1
        return JAIL
      else
        return square
    end
  end

  def chance_move(square)
    case rand(16)
      when 0
        return GO
      when 1
        return JAIL
      when 2
        return C1
      when 3
        return E3
      when 4
        return H2
      when 5
        return R1
      when 6, 7
        return NEXT_RAILROAD[square]
      when 8
        return NEXT_UTILITY[square]
      when 9
        next_square = (square - 3) % NUM_SQUARES
        if is_community_chest(next_square)
          return community_chest_move(next_square)
        else
          return next_square
        end
      else
        return square
    end
  end

  def is_community_chest(square)
    [2, 17, 33].include?(square)
  end

  def is_chance(square)
    [7, 22, 36].include?(square)
  end
end

dice_sides = 4
game = Monopoly.new

##Test 3x doubles -> JAIL
#assert_equal 4, game.take_turn(0, [2, 2])
#assert_equal 8, game.take_turn(4, [2, 2])
#assert_equal Monopoly::JAIL, game.take_turn(8, [2, 2])
#
##Test G2J
#assert_equal Monopoly::JAIL, game.take_turn(25, [2, 3])
#
##Test wrapping around
#assert_equal 0, game.take_turn(35, [2, 3])

counts = [0] * 40
square = 0

#puts 100.times.map { game.chance_move(7) }.inspect
#
#exit

1000000.times do
  roll = 2.times.map { rand(4) + 1 }
  square = game.take_turn(square, roll)
  #puts "Roll of #{roll[0]} + #{roll[1]} --> #{square}"
  counts[square] += 1
end

h = []
counts.each_with_index { |count, i| h << [i, count] }
puts h.sort_by { |i, count| -count }.inspect
#puts counts.sort_by { |square, count| -count }.inspect

