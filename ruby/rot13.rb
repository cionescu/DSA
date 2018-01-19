require 'irb'

def convert alphabet, char
  upcase = char.downcase != char
  new_idx = (alphabet.index(char.downcase) + 13) % alphabet.length
  upcase ? alphabet[new_idx].upcase : alphabet[new_idx]
end

alphabet = 'abcdefghijklmnopqrstuvwxyz'
encrypted_message = 'Jul qvq gur puvpxra pebff gur ebnq?'
result = ""
encrypted_message.each_char do |char|
  if [' ', '?', '!'].include?(char)
    result << char
  else
    result << convert(alphabet, char)
  end
end
puts result
