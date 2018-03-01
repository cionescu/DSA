pollution <- read.csv("avgpm25.csv", colClasses=c("numeric", "character", "factor", "numeric", "numeric"))

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

# 2D graphs

side_by_side_box_plots <- function() {
  boxplot(pm25 ~ region, data=pollution, col="red")
}

scatter <- function() {
  with(pollution, plot(latitude, pm25, col=region))
  abline(h=12, lwd=2, lty=2)
}

lattice_plot <- function() {
  library(lattice)
  data(state)
  state <- data.frame(state.x77, region=state.region)
  xyplot(Life.Exp ~ Income | region, data=state, layout=c(4,1))
}
