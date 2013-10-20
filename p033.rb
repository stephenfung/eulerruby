def improper_cancellable?(num, den)
   ratio = Rational(num, den)
  #Check both digits of the numerator
  sn = num.to_s
  sd = den.to_s

  #No trivial answers
  return nil if sn[1] == "0" and sd[1] == "0"

  #Try cancelling both bits
  (0..1).each do |i|
    if sd.include?(sn[i])
      if sd[0] == sn[i]
        return true if sd[1] != "0" && ratio == Rational(sn[1-i], sd[1])
      else
        return true if sd[0] != "0" && ratio == Rational(sn[1-i], sd[0])
      end
    end
  end
  nil
end

matches = []
(10..99).each do |num|
  (num+1..99).each do |den|
    matches << [num, den] if improper_cancellable?(num, den)
  end
end

puts matches.inject(Rational(1, 1)) { |prod, m| prod *= Rational(m[0], m[1]) }
