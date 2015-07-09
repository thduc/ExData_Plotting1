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

# open the pnp file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
# draw plot
plot(x = hpcExtracted$DateTimeValue, y = hpcExtracted$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA)
# close graphic device
dev.off()