class ContinuedFraction
  attr_accessor :start_part, :periodic_part

  def convergent_fraction(number)
    intparts = start_part
    while intparts.length < number
      intparts += periodic_part
    end
    ContinuedFraction.convert_to_fraction(intparts[0, number])
  end

  def self.new_for_square_root(n)
    i = ContinuedFraction.new
    i.start_part, i.periodic_part = for_square_root(n)
    i
  end

  def self.for_square_root(n)
    return nil if is_square(n)

    term = [Math.sqrt(n).floor, 1, Math.sqrt(n).floor]
    counter = 0
    seen = {}
    seen[term] = counter
    intparts = [term[0]]
    while true
      counter += 1
      int, num, den = term
      den2 = (n - den ** 2)
      unless den2 % num == 0
        raise Exception.new("assertion failed")
      end
      den2 = den2 / num
      floorpart = ((Math.sqrt(n) + den) / den2).floor
      intparts << floorpart
      term = [floorpart, den2, -(den - floorpart * den2)]
      if seen.include?(term)
        return [intparts[0, seen[term]], intparts[seen[term], counter - seen[term]]]
      else
        seen[term] = counter
      end
    end
  end

  def self.convert_to_fraction(intparts)
    frac = nil
    n = intparts.length
    return intparts[0] if n == 0
    (n-1).downto(0) do |i|
      if frac
        frac = 1 / frac + intparts[i]
      else
        frac = Rational(intparts[i])
      end
    end
    frac
  end
end
