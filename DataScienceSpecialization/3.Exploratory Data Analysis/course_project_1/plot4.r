colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.csv("./household_power_consumption.txt", header=TRUE, sep=";", colClasses=colClasses, na.strings = c("?"))
dates <- paste(data$Date, data$Time)
data$DateTime <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data[c("Date", "Time")] <- list(NULL)

png("plot4.png", width = 480, height = 480, units = "px")
par(bg = "transparent")
par(mfrow=c(2,2))

# Plot 1
plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# Plot 2
plot(data$DateTime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Plot 3
plot(data$DateTime, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_1, type="l", col="black")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), cex=.75)

# Plot 4
plot(data$DateTime, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
