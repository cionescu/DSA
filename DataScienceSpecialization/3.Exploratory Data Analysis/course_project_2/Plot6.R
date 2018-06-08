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

baltimore <- summary[(summary$fips=="24510"), ]
baltimore <- aggregate(Emissions ~ year, data = baltimore, FUN = sum)
losangeles <- summary[(summary$fips=="06037"),]
losangeles <- aggregate(Emissions ~ year, data = losangeles, FUN = sum)
baltimore$County <- "Baltimore"
losangeles$County <- "Los Angeles"
Data <- rbind(baltimore, losangeles)
func <- function(){
  f <- function(x) as.character(round(x,2))
  f
}
png(filename = "Plot6.png", width = 500, height = 480, units = "px")
ggplot(Data, aes(x=factor(year), y=Emissions, fill=County)) + geom_bar(aes(fill = County), position = "dodge", stat="identity") + labs(x = "Year") + labs(y = expression("Total Emissions (in log scale) of PM"[2.5])) + xlab("year") + ggtitle(expression("Motor vehicle emission in Baltimore and Los Angeles")) + scale_y_continuous(trans = log_trans(), labels = func())
dev.off()
