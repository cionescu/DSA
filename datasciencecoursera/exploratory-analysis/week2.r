simple_lattice <- function() {
  library(lattice)
  library(datasets)
  xyplot(Ozone ~ Wind, airquality)
}

factor_month <- function() {
  library(lattice)
  library(datasets)
  ## Convert Month to a factor variable
  airquality <- transform(airquality, Month = factor(Month))
  xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
}

lattice_behaviour <- function() {
  p <- xyplot(Ozone ~ Wind, airquality) ## Nothing Happens
  print(p) ## Plot Appears
}

lattice_panel_function <- function() {
  set.seed(10)
  x <- rnorm(100)
  f <- rep(0:1, each = 50)
  y <- x + f - f * x + rnorm(100, sd = 0.5)
  f <- factor(f, labels=c("Group 1", "Group 2"))
  xyplot(y ~ x | f, layout = c(2,1)) ## Plot with 2 panels
}


custom_panel_function <- function() {
  set.seed(10)
  x <- rnorm(100)
  f <- rep(0:1, each = 50)
  y <- x + f - f * x + rnorm(100, sd = 0.5)
  f <- factor(f, labels=c("Group 1", "Group 2"))
  xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) ## First call the default panel function for xyplot
    panel.abline(h = median(y), lty = 2) ## Add a dashed horizontal line at the median
    panel.lmline(x, y, col=2) ## simple linear regression line
  })
}
