##Read complete data
completeData <- read.csv(file = "household_power_consumption.txt", header = T, 
                         sep = ";", na.strings="?", nrows = 2075259)

##Convert dates to filter
completeData$Date <- as.Date(completeData$Date, format="%d/%m/%Y")
data <- subset(completeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#Clear RAM
remove(completeData)

##Create plot
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#Save
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()


