## Plot 4

# Reading all the dataset into R

power_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

#Format date variable
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")

#Extracting 2007-02-01 to 2007-02-01 data 
ext_data <- subset(power_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#For memory management remove larger dataset
ext_data$Global_active_power
rm(power_data)

# Reformating the dates
date_time <- paste(as.Date(ext_data$Date), ext_data$Time)
ext_data$Date_time <- as.POSIXct(date_time)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,0,0))
with(ext_data, {
  plot(Global_active_power ~ Date_time, type = "l", ylab="Global Active Power (kilowatts)", xlab = "")
  plot(Voltage~Date_time, type="l", ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1 ~ Date_time, type="l", ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~Date_time,col='red')
  lines(Sub_metering_3~Date_time,col='blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Date_time, type="l", ylab="Global Rective Power (kilowatts)",xlab="datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()