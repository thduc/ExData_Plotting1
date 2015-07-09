# read data
# hpc <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", stringsAsFactors = FALSE)
hpc <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
# convert string to date
hpc$DateValue <- as.Date(hpc$Date, "%d/%m/%Y")
# extract the dataset
hpcExtracted <- subset(hpc, (as.Date("2007-02-01") <= hpc$DateValue) & (hpc$DateValue <= as.Date("2007-02-02")))
# remove unused data
rm(hpc)

# convert date, time string to datetime variable
hpcExtracted$DateTimeValue <- strptime(paste(hpcExtracted$Date, hpcExtracted$Time), "%d/%m/%Y %H:%M:%S")
# convert Global_active_power
hpcExtracted$Global_active_power <- as.numeric(hpcExtracted$Global_active_power)
# convert Voltage
hpcExtracted$Voltage <- as.numeric(hpcExtracted$Voltage)
# convert sub-metering
hpcExtracted$Sub_metering_1 <- as.numeric(hpcExtracted$Sub_metering_1)
hpcExtracted$Sub_metering_2 <- as.numeric(hpcExtracted$Sub_metering_2)
hpcExtracted$Sub_metering_3 <- as.numeric(hpcExtracted$Sub_metering_3)
# convert Global_reactive_power
hpcExtracted$Global_reactive_power <- as.numeric(hpcExtracted$Global_reactive_power)

# open the pnp file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# split graphic device
par(mfrow=c(2,2))
# Global_active_power
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Global_active_power, type = "l", ylab = "Global Active Power", xlab = NA)
# Voltage
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
# Sub metering
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = NA)
lines(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_2, col = "red")
lines(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lty = c(1, 1))
# Global_reactive_power
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
# close graphic device
dev.off()