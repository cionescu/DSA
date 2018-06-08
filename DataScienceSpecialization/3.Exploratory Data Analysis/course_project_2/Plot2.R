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

if (!"BaltimoreData" %in% ls()) {
  BaltimoreData <- summary[summary$fips == "24510", ]
}
png(filename = "Plot2.png", width = 480, height = 480, units = "px")
if (!"totalEmissionsBaltimore" %in% ls()) {
  totalEmissionsBaltimore <- aggregate(BaltimoreData$Emissions, list(BaltimoreData$year), FUN = "sum")
}
plot(totalEmissionsBaltimore, type = "b", pch = 20, col = "blue", xlab = "Year", main = expression('Total PM'[2.5]*" Emissions in Baltimore City, Maryland from 1999 to 2008"), ylab = expression('Total PM'[2.5]*" Emission (in tons)"))
dev.off()
