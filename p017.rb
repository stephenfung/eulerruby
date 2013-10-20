def number_to_words(n)
  case n
    when 1
      "one"
    when 2
      "two"
    when 3
      "three"
    when 4
      "four"
    when 5
      "five"
    when 6
      "six"
    when 7
      "seven"
    when 8
      "eight"
    when 9
      "nine"
    when 10
      "ten"
    when 11
      "eleven"
    when 12
      "twelve"
    when 13
      "thirteen"
    when 14
      "fourteen"
    when 15
      "fifteen"
    when 16
      "sixteen"
    when 17
      "seventeen"
    when 18
      "eighteen"
    when 19
      "nineteen"
    when 20
      "twenty"
    when 30
      "thirty"
    when 40
      "forty"
    when 50
      "fifty"
    when 60
      "sixty"
    when 70
      "seventy"
    when 80
      "eighty"
    when 90
      "ninety"
    when 1000
      "one thousand"
    when (100..999)
      if n % 100 == 0
        number_to_words(n/100) + " hundred"
      else
        number_to_words(n/100) + " hundred and " + number_to_words(n%100)
      end
    else
      #It's a normal 2-digit number
      number_to_words(n / 10 * 10) + "-" + number_to_words(n % 10)
  end
end

def count_letters(s)
  s.chars.count{|c| ("a".."z").include? c}
end

puts (1..1000).map{|n|count_letters(number_to_words(n))}.inject(0, &:+)