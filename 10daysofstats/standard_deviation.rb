# https://www.hackerrank.com/challenges/s10-standard-deviation/problem

count = gets.chomp
numbers = gets.chomp.split(" ").map(&:to_i)

mean = numbers.sum.to_f / numbers.count

std = numbers.inject(0){ |sum, elem| sum += (elem - mean) * (elem - mean) }.to_f / numbers.count

puts Math.sqrt(std).round(1)
