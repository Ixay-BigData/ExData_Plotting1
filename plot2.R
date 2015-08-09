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

##Create plot
plot(data$Datetime, data$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l")

#Save
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
