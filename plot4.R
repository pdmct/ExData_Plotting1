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

# convert the time to a POSIXct class
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
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA,
    type = "quartz")

# setup lattice of graphs
par(mfrow=c(2,2))

# first plot
# setup the plot
with(hpd, plot(Global_active_power ~ Time, 
               type = "n", 
               ylab = "Global Active Power", 
               xlab = ""))
# add the lines
lines(hpd$Time, hpd$Global_active_power)

#second plot (row order)
with(hpd, plot(Voltage ~ Time,
               type = "n",
               ylab = "Voltage",
               xlab = "datetime"))
lines(hpd$Time, hpd$Voltage)

# third plot
# setup the plot area
with(hpd, plot(Sub_metering_1 ~ Time, type = "n", 
               ylab = "Energy sub metering", 
               xlab = ""))

# add the lines
lines(hpd$Time, hpd$Sub_metering_1, col = "black")
lines(hpd$Time, hpd$Sub_metering_2, col = "red")
lines(hpd$Time, hpd$Sub_metering_3, col = "blue")

# add the legend
legend("topright",
       bty = "n",
       seg.len = 2, 
       lty = c(1,1,1),
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"))

# fourth plot
with(hpd, plot(Global_reactive_power ~ Time, type="n",
               xlab = "datetime"))

lines(hpd$Time, hpd$Global_reactive_power)
axis(2, at = c(0,0.1,0.2,0.3,0.4,0.5))

# close the device
dev.off()