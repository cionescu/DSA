# https://www.hackerrank.com/challenges/s10-weighted-mean/problem

count = gets.chomp
numbers = gets.chomp.split(" ").map(&:to_i)
weights = gets.chomp.split(" ").map(&:to_i)
weighted_sum = numbers.each_with_index.inject(0){ |sum, elem| sum += elem.first * weights[elem.last] }
puts (weighted_sum.to_f / weights.sum).round(1)
