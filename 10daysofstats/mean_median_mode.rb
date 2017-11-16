# https://www.hackerrank.com/challenges/s10-basic-statistics/problem

count = gets.chomp.to_i
numbers = gets.chomp.split(" ").map(&:to_i)
puts numbers.sum.to_f / numbers.count # Mean
puts numbers.sort[(numbers.count/2-1)..(numbers.count/2)].sum.to_f / 2 # Median

sorted_occurrences = numbers.each_with_object(Hash.new(0)) { |num, counts| counts[num] += 1 }.to_a.sort_by{ |el| [el.last, el.first] }
_, occ_count = sorted_occurrences.last
# If there sample is multimodal, we want to choose the smallest value
mode, _ = sorted_occurrences.detect{ |element| element.last == occ_count }
puts mode
