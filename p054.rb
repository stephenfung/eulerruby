require './lib/functions'

class Card
  def initialize_rank_to_value
    @rank_to_value = (2..9).inject({}) { |h, n| h[n.to_s] = n; h }
    @rank_to_value["T"] = 10
    @rank_to_value["J"] = 11
    @rank_to_value["Q"] = 12
    @rank_to_value["K"] = 13
    @rank_to_value["A"] = 14
  end

  def initialize(s)
    @rank = s[0]
    @suit = s[1]

    initialize_rank_to_value()
  end

  def suit
    @suit
  end

  def rank
    @rank
  end

  def rank_value
    @rank_to_value[@rank]
  end

  def rank_difference(card2)
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end

class Hand
  def initialize(cards)
    @cards = cards.map { |c| Card.new(c) }
  end

  def <=> (other)
    return -1 if self.hand_class < other.hand_class
    return 1 if self.hand_class > other.hand_class

    #It's the same class, now compare within class.
    #All classes will have the same distribution of pairs, triples etc.
    #Go by the ranks in descending quantity and compare the rank.
    c1 = self.sorted_cards
    c2 = other.sorted_cards

    c1.each_with_index do |group, i|
      diff = c1[i].last[0].rank_value - c2[i].last[0].rank_value
      return -1 if diff < 0
      return 1 if diff > 0
    end

    #It's the exact same
    return 0
  end

  def sorted_cards
    #Sort the cards into groups by rank (pairs, etc.), and within each group, sort by descending rank
    @cards.group_by{ |c| c.rank }.sort_by{ |g, cards| [cards.count, cards[0].rank_value] }.reverse
  end

  def is_straight_flush
    is_flush && is_straight
  end

  def is_flush
    @cards.map{ |c| c.suit }.all_same?
  end

  def is_straight
    values = @cards.map{ |c| c.rank_value }.sort
    first = values.first
    values.map { |v| v - values.first } == [0, 1, 2, 3, 4]
  end

  def rank_groupings
    @cards.group_by{ |c| c.rank }.map { |g, cards| cards.count }.sort
  end

  def is_four_of_a_kind
    rank_groupings == [1, 4]
  end

  def is_full_house
    rank_groupings == [2, 3]
  end

  def is_triple
    rank_groupings == [1, 1, 3]
  end

  def is_two_pair
    rank_groupings == [1, 2, 2]
  end

  def is_one_pair
    rank_groupings == [1, 1, 1, 2]
  end

  def hand_class
    return 10 if is_straight_flush
    return 9 if is_four_of_a_kind
    return 8 if is_full_house
    return 7 if is_flush
    return 6 if is_straight
    return 5 if is_triple
    return 4 if is_two_pair
    return 3 if is_one_pair
    return 2 #high card
  end

end

def p1_wins(cards)
  p1 = Hand.new(cards[0, 5])
  p2 = Hand.new(cards[5, 5])
  diff = p1 <=> p2
  puts "#{p1.inspect} > #{p2.inspect}" if diff > 0
  puts "#{p1.inspect} = #{p2.inspect}" if diff == 0
  puts "#{p1.inspect} < #{p2.inspect}" if diff < 0

  diff > 0
end

p1_win_count = 0
#Load the hands
File.open("data/poker.txt", "r") do |file|
  while(line = file.gets)
    p1_win_count += 1 if p1_wins(line.split(' '))
  end
end
puts p1_win_count