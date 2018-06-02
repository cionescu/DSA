require "concurrent"

WORKERS = 10
MAX_DELAY = 10

class MyQueue
  attr_reader :workers

  def initialize
    @workers = []
  end

  def map &block
    @workers << Concurrent::Promise.execute(&block)
  end

  def reduce accumulator
    workers.each_with_object(accumulator) do |worker, acc|
      yield worker.value, acc
    end
  end

end

class ItemWorker
  def call id
    delay = rand(0..MAX_DELAY)
    puts "Worker ##{id} going to sleep for #{delay}"
    sleep delay
    puts "Worker ##{id} is awake"
    true
  end
end

queue = MyQueue.new
worker = ItemWorker.new

## MAP
WORKERS.times do |i|
  queue.map{ worker.call(i) }
  puts "Enqueued ##{i}"
end

## REDUCE
queue.reduce([]) do |worker, results|
  results << worker
end

puts "All done"
