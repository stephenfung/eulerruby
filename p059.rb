require './lib/functions'

ciphertext = ""
File.open('data/cipher1.txt', "r") do |file|
  while(line = file.gets)
    ciphertext += line.split(',').map { |fragment| fragment.to_i.chr }.join
  end
end

def decrypt(ciphertext, key)
  plaintext = ""
  i = 0
  for c in ciphertext.chars
    plaintext += (key[i].ord ^ c.ord).chr
    i += 1
    i %= key.length
  end
  plaintext
end

def is_decrypted(plaintext)
  plaintext.include?("the") && plaintext.include?("that") && plaintext.include?("and")
end

a_z = ('a'..'z').to_a
possible_keys = a_z.product(a_z, a_z)

possible_keys.each do |k|
  plaintext = decrypt(ciphertext, k.map { |c| c.ord })
  if is_decrypted(plaintext)
    puts "GOT IT #{k.inspect}", plaintext
    puts plaintext.chars.inject(0) { |sum, c| sum + c.ord }
  end

end