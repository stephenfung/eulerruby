require 'date'

puts (1901..2000).to_a.product((1..12).to_a).map{|y, m| Date.civil(y,m)}.count{|d|d.wday == 0}
