library("data.table")

setwd("./")

#Reads in data from file then subsets data for specified dates
power_consumption_dataset <- data.table::fread(input = "household_power_consumption.txt"
                                               , na.strings="?")
# Prevents Scientific Notation
power_consumption_dataset[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

## concatenate date and time column into  as POSIXct date time object
power_consumption_dataset[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_consumption_dataset <- power_consumption_dataset[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(power_consumption_dataset$dateTime, power_consumption_dataset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(power_consumption_dataset$dateTime,power_consumption_dataset$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(power_consumption_dataset$dateTime, power_consumption_dataset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_consumption_dataset$dateTime, power_consumption_dataset$Sub_metering_2, col="red")
lines(power_consumption_dataset$dateTime, power_consumption_dataset$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(power_consumption_dataset$dateTime, power_consumption_dataset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()