# https://www.hackerrank.com/challenges/s10-quartiles/problem

def split_in_half_and_get_median arr
  arr.sort!
  if arr.count % 2 == 0
    first_half, second_half = arr.each_slice(arr.count/2).to_a
    median = (first_half.last + second_half.first) / 2
    [first_half, second_half, median]
  else
    median = arr[arr.count/2]
    first_half = arr[0..(arr.count / 2 - 1)]
    second_half = arr[(arr.count / 2 + 1)..arr.count]
    [first_half, second_half, median]
    [first_half, second_half, median]
  end
end

count = gets.chomp.to_i
numbers = gets.chomp.split(" ").map(&:to_i)

first_half, second_half, q2 = split_in_half_and_get_median(numbers)
_, _, q1 = split_in_half_and_get_median(first_half)
_, _, q3 = split_in_half_and_get_median(second_half)
puts q1
puts q2
puts q3
