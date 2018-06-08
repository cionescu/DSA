library(plyr)
library(ggplot2)
library(data.table)
library(grid)
library(scales)
library(httr)

if (!"summary" %in% ls()) {
  summary <- readRDS("../data/summary.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("../data/scc.rds")
}
png(filename = "./Plot1.png", width = 480, height = 480, units = "px")

if (!"totalEmissions" %in% ls()) {
  totalEmissions <- aggregate(summary$Emissions, list(summary$year), FUN = "sum")
}
plot(totalEmissions, type = "b", pch = 13, col = "red", xlab = "Year", main = expression('Total PM'[2.5]*" Emissions in the United States from 1999 to 2008"), ylab = expression('Total PM'[2.5]*" Emission (in tons)"))
dev.off()
