# read data
# hpc <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", stringsAsFactors = FALSE)
hpc <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
# convert string to date
hpc$DateValue <- as.Date(hpc$Date, "%d/%m/%Y")
# extract the dataset
hpcExtracted <- subset(hpc, (as.Date("2007-02-01") <= hpc$DateValue) & (hpc$DateValue <= as.Date("2007-02-02")))
# remove unused data
rm(hpc)

# convert Global_active_power
hpcExtracted$Global_active_power <- as.numeric(hpcExtracted$Global_active_power)

# open the pnp file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# draw histogram
hist(hpcExtracted$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# close graphic device
dev.off()