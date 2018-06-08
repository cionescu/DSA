# Generate numbers from a linear model
# y = b0 + b1 * x + e
# e ~ N(0, 2^2), x ~ N(0, 1^2), b0 = 0.5, b1 = 2

y <- function() {
  set.seed(20)
  x <- rnorm(100)
  e <- rnorm(100, 0, 2)
  0.5 + 2 * x + e
}

# Generate from a poisson model
# y ~ Poisson(u)
# log u = b0 + b1 * x
# b0 = 0.5, b1 = 0.3
