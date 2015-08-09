##Set language
Sys.setlocale("LC_TIME", "English")

##Read complete data
completeData <- read.csv(file = "household_power_consumption.txt", header = T, 
                         sep = ";", na.strings="?", nrows = 2075259)

##Convert dates to filter
completeData$Date <- as.Date(completeData$Date, format="%d/%m/%Y")
data <- subset(completeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#Clear RAM
remove(completeData)

##Merge times
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXlt(datetime)
#Clear RAM
remove(datetime)


##Set parameters for multiplot
par(mfrow = c(2,2))

##Create plot2
plot(data$Datetime, data$Global_active_power, xlab = "", 
     ylab = "Global Active Power", type = "l")

##Create voltage plot
plot(data$Datetime, data$Voltage, xlab = "datetime", 
     ylab = "Voltage", type = "l")

##Create plot3
with(data,{
  plot(data$Datetime, data$Sub_metering_1, xlab = "", 
       ylab = "Energy sub metering", type = "l")
  lines(data$Datetime, data$Sub_metering_2, col = "red")
  lines(data$Datetime, data$Sub_metering_3, col = "blue")
  
})
#Add legend
legend("topright", lty = 1, lwd = 1, bty = "n", cex = .5, pt.cex = 1, y.intersp = .3, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Create global_reactive_power plot
plot(data$Datetime, data$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "l")

#Save
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
