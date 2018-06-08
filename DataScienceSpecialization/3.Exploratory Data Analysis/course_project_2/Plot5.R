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

if (!"Motor" %in% ls()) {
  Motor <- ddply(summary[summary$fips == "24510" & summary$type == "ON-ROAD",], .(type, year), summarize, TotalEmissions = sum(Emissions))
}
png(filename = "Plot5.png", width = 500, height = 480, units = "px")
ggplot(Motor, aes(year, TotalEmissions)) + geom_line(color = "green") + geom_point() + labs(title = "Total Emissions from Motor Vehicles in Baltimore City", x = "Year", y = "Total Emissions")
dev.off()
