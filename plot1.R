## plot1.R
## Week 1 Exploratory Data Analysis Project

## load the data

# set working directory to cloned repo location, data file is in parent directory

fileLoc <- "../household_power_consumption.txt"
household_data <- read.table(file = fileLoc, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# subset to just the dates we are interested in
hpd <- subset(household_data, household_data$Date == "1/2/2007" | household_data$Date == "2/2/2007")

# convert the columns into the appropriate types
hpd$Date <- as.Date(hpd$Date, format = "%d/%m/%Y")

# convert the time column to a POSIXct object 
hpd$Time <- as.POSIXct(paste(format(hpd$Date, "%Y%m%d"), hpd$Time), 
                       format="%Y%m%d %T")
hpd$Global_active_power <- as.numeric(hpd$Global_active_power)
hpd$Global_reactive_power <- as.numeric(hpd$Global_reactive_power)
hpd$Voltage <- as.numeric(hpd$Voltage)
hpd$Global_intensity <- as.numeric(hpd$Global_intensity)
hpd$Sub_metering_1 <- as.numeric(hpd$Sub_metering_1)
hpd$Sub_metering_2 <- as.numeric(hpd$Sub_metering_2)
hpd$Sub_metering_3 <- as.numeric(hpd$Sub_metering_3)


# make the plot
# set the plot size and create the device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA,
    type = "quartz")

with(hpd, hist(Global_active_power, col="red", 
               xlab = "Global Active Power (kilowatts)", 
               main = "Global Active Power"))

#adjust the left axis
axis(2, at =c (0,200,400,600,800,1000,1200), labels=TRUE)

# close the device
dev.off()