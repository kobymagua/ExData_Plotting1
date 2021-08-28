# Reading all the dataset into R

power_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE, comment.char = "", quote = '\"')

#Format date variable
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")

#Extracting 2007-02-01 to 2007-02-01 data 
ext_data <- subset(power_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#For memory management remove larger dataset

rm(power_data)

# Reformating the dates
date_time <- paste(as.Date(ext_data$Date), ext_data$Time)
ext_data$Date_time <- as.POSIXct(date_time)

plot(ext_data$Global_active_power ~ ext_data$Date_time, type = "l", ylab = "Global Active Power (kilowatts)", xlab ="" )

# Sending to graphic device, PNG
dev.copy(png, file = "Plot2.png", height = 480, width = 480)
dev.off()

