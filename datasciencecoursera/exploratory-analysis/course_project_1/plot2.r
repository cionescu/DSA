colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.csv("./household_power_consumption.txt", header=TRUE, sep=";", colClasses=colClasses)
dates <- paste(data$Date, data$Time)
data$DateTime <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data[c("Date", "Time")] <- list(NULL)

plot(data$DateTime, data$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(data$DateTime, data$Global_active_power, type="l")

dev.copy(png,'plot2.png')
dev.off()
