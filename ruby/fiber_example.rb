def fiber_example debug: false
  puts "Do Something"
  Fiber.yield if debug
  puts "Finish doing something"
end

puts "The regular flow -- "
fiber_example

puts "With an interjection --- "

fiber = Fiber.new { fiber_example(debug: true) }
fiber.resume
fiber.resume(2)

