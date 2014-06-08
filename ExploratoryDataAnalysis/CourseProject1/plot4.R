rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)
data5row <- read.table("filtered.txt", sep = ";", header = TRUE, nrow = 5)
classes <- sapply(data5row, class)
my_data <- read.table("filtered.txt", sep = ";", header = TRUE, colClasses = classes)
datetime <- paste(my_data$Date, my_data$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
datetime <- as.POSIXct(datetime)

png(filename = "plot4.png")
par(mfrow = c(2, 2))
plot(datetime, my_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(datetime, my_data$Voltage, type = "l", ylab = "Voltage")

plot(DateTime, my_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black", ylim=range(c(my_data$Sub_metering_1, my_data$Sub_metering_2, my_data$Sub_metering_3)))
par(new = TRUE)
plot(DateTime, my_data$Sub_metering_2, type = "l", axes = FALSE, xlab = "", ylab = "", col = "red", ylim=range(c(my_data$Sub_metering_1, my_data$Sub_metering_2, my_data$Sub_metering_3)))
par(new = TRUE)
plot(DateTime, my_data$Sub_metering_3, type = "l", axes = FALSE, xlab = "", ylab= "", col = "blue", ylim=range(c(my_data$Sub_metering_1, my_data$Sub_metering_2, my_data$Sub_metering_3)))

plot(datetime, my_data$Global_reactive_power, type = "l", ylab = "Global_rective_power")
dev.off()
