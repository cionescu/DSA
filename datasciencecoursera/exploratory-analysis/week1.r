pollution <- read.csv("data/avgpm25.csv", colClasses=c("numeric", "character", "factor", "numeric", "numeric"))

five_number_summary <- function() {
  summary(pollution$pm25)
}

box_plot <- function() {
  boxplot(pollution$pm25, col="blue")
  abline(h=12)
}

histogram <- function() {
  hist(pollution$pm25, col="green")
  abline(v=12, col="red", lwd=2)
  abline(v=median(pollution$pm25), col="magenta", lwd=4)
  rug(pollution$pm25 )
}

bar_plot <- function() {
  barplot(table(pollution$region), col="wheat", main="Number of Counties in Each Region")
}

side_by_side_box_plots <- function() {
  boxplot(pm25 ~ region, data=pollution, col="red")
}

scatter <- function() {
  with(pollution, plot(latitude, pm25, col=region))
  abline(h=12, lwd=2, lty=2)
}

# Plots created with a single function call, most useful for
# conditioning types of plots

lattice_plot <- function() {
  library(lattice)
  data(state)
  state <- data.frame(state.x77, region=state.region)
  xyplot(Life.Exp ~ Income | region, data=state, layout=c(4,1))
}

# GGPlot2 - automatically deals with spacings, text and titles but
# is highly customizable

ggplot_graph <- function() {
  library(ggplot2)
  data(mpg)
  # Plot the size of the engine against the highway consumption
  # and non-linear trend line
  qplot(displ, hwy, data=mpg) + geom_point() + geom_smooth()
}

# Boxplot of the distribution of ozone by month

boxplot_distribution <- function() {
  library(datasets)
  airquality <- transform(airquality, Month = factor(Month))
  boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone")
}

# Arbitrary plot with the base plotting function

base_plot <- function() {
  library(datasets)
  with(airquality, plot(Wind, Ozone))
  title(main="Ozone and Wind in NY City")
}

# Multiple base plots with

multi_plot <- function() {
  library(datasets)
  par(mfrow=c(1,2), mar=c(2, 2, 2, 2), oma=c(2, 2, 2, 2))
  with(airquality, {
    plot(Wind, Ozone, main="Wind and Ozone")
    plot(Solar.R, Ozone, main="Solar and Ozone")
    mtext("Comparing Wind to Ozone and Solar to Ozone", outer=TRUE)
    text(10, 1, "Text", col="red")
  })
}

# Different colors for groups

group_colours <- function() {
  x <- rnorm(100)
  y <- x + rnorm(100)
  g <- gl(2, 50, labels=c("Male", "Female"))
  plot(x, y, type="n")
  points(x[g=="Male"], y[g=="Male"], col="green")
  points(x[g=="Female"], y[g=="Female"], col="blue")
}
