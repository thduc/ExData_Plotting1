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
# convert sub-metering
hpcExtracted$Sub_metering_1 <- as.numeric(hpcExtracted$Sub_metering_1)
hpcExtracted$Sub_metering_2 <- as.numeric(hpcExtracted$Sub_metering_2)
hpcExtracted$Sub_metering_3 <- as.numeric(hpcExtracted$Sub_metering_3)

# open the pnp file
png(filename = "plot3.png", width = 480, height = 480, units = "px")
# sub metering #1
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = NA)
# sub metering #2
lines(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_2, col = "red")
# sub metering #3
lines(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Sub_metering_3, col = "blue")
# legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1))
# close graphic device
dev.off()