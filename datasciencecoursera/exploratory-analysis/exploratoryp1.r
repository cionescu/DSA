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
