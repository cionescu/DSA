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

if (!"CoalNEI" %in% ls()) {
  Coal <- SCC[grep("Comb.*Coal", SCC$Short.Name), "SCC"]
  CoalNEI <- summary[summary$SCC %in% Coal, ]
}
if (!"TData" %in% ls()) {
  TData <- ddply(CoalNEI, .(year), summarise, TotalEmissions = sum(Emissions))
}
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
ggplot(TData, aes(year, TotalEmissions)) + geom_line(color = "red") + geom_point() + labs(title = "Total Emissions from Coal Combustion-Related Sources", x = "Year", y = "Total Emissions")
dev.off()
