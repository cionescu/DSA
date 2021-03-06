colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.csv("./household_power_consumption.txt", header=TRUE, sep=";", colClasses=colClasses, na.strings = c("?"))
dates <- paste(data$Date, data$Time)

# Alternative 1-liner data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

data$DateTime <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data[c("Date", "Time")] <- list(NULL)

png("plot1.png", width = 480, height = 480, units = "px")
par(bg = "transparent")
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()
