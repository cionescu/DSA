# https://www.hackerrank.com/challenges/s10-interquartile-range/problem

def split_in_half_and_get_median arr
  arr.sort!
  if arr.count % 2 == 0
    first_half, second_half = arr.each_slice(arr.count/2).to_a
    median = (first_half.last + second_half.first).to_i / 2
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
values = gets.chomp.split(" ").map(&:to_i)
frequencies = gets.chomp.split(" ").map(&:to_i)

numbers = values.flat_map.with_index{ |number, index| [number]*frequencies[index] }

first_half, second_half, q2 = split_in_half_and_get_median(numbers)
_, _, q1 = split_in_half_and_get_median(first_half)
_, _, q3 = split_in_half_and_get_median(second_half)
puts (q3 - q1).round(1)
