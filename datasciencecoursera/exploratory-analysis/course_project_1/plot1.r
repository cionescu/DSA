plot1 <- function() {
  colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
  data <- read.csv("./household_power_consumption.txt", header=TRUE, sep=";", colClasses=colClasses)
  dates <- paste(data$Date, data$Time)
  data$DateTime <- strptime(dates, "%d/%m/%Y %H:%M:%S")
  data[c("Date", "Time")] <- list(NULL)
  hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  dev.copy(png,'plot1.png')
  dev.off()
}

plot1()
