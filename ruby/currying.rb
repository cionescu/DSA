# Currying is a technique in which a function accepts n parameters and turns it into a sequence of n
# functions, each of them take 1 parameter.

power_function = -> (x, z) {
    (x) ** z
}

base = gets.to_i
raise_to_power = power_function.curry.(base)

power = gets.to_i
puts raise_to_power.(power)
