import matplotlib.pyplot as plt
from random import randint

def chooseNextPoint(index, points):
  # print "Choosing new point %d" % index
  if index < len(points) - 1 and points[index + 1] > points[index]:
    return index + 1
  elif index > 0 and points[index-1] > points[index]:
    return index - 1
  return index

def run(points):
  index = randint(0, len(points) - 1)
  # print points
  # print "Initializing with index: %d value: %d" % (index, points[index])
  while True:
    new_index = chooseNextPoint(index, points)
    # print "New point has index: %d value: %d" % (new_index, points[new_index])
    if index == new_index:
      return index
    index = new_index

def generateWorld():
  length = randint(100, 150)
  population = []
  for i in xrange(0, length):
    population.append(randint(0, 500))
  return population

if __name__ == '__main__':
  population = generateWorld()
  max_value = max(population)
  print population
  print "Overall solution has index: %d and value: %d" % (population.index(max_value), max_value)
  for i in xrange(0, 10):
    solution = run(population)
    if population[solution] == max_value:
      print "MAX SOLUTION FOUND: %d and value: %d" % (solution, population[solution])
    else:
      print "Solution has index: %d and value: %d" % (solution, population[solution])
  # plt.plot(population)
  # plt.ylabel('some numbers')
  # plt.show()
