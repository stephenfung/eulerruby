coins = [1, 2, 5, 10, 20, 50, 100, 200]

#Dynamic programming -- compute the ways that we can make i cents with 0 or more of the coins up to c
#coin[c][i] = # of ways you can make i cents with the coins up to c
#           = coin[c-1][i] (# of ways you can make it with the coins up to c with 0 c coins)
#             + coin[c][i-value(c)] (+ # of ways you can make it with the coins up to c with 1 or more c coins)
coin_ways = []
coin_ways << (1..200).inject({}){|h, i| h[i] = 1; h}  #How many ways can you do it just with pennies?
for c in (1...coins.length)
  coin_value = coins[c]
  last_ways = coin_ways.last
  coin_ways << ways = {}
  for i in (1..200)
    #If you could do it without this coin, those ways still count
    ways[i] = last_ways[i]
    #Then add the ways you can do it with at least one of these coins
    if(coin_value <= i)
      ways[i] += ways[i - coin_value] || 1 #the || 1 is to handle the case when you i = coin_value -- just one of the new coins
    end
  end
  coin_ways << ways
end
puts coin_ways.last[200]