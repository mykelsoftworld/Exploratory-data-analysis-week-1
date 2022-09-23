 library("data.table")
#
 setwd("./")

 #Reads in data from file then subsets data for specified dates
 power_consumption_dataset <- data.table::fread(input = "household_power_consumption.txt"
                                                , na.strings="?")
 # enforce standard format as numeric
 power_consumption_dataset[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

 # # concatenate date and time column into  as POSIXct date time object
 power_consumption_dataset[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

 # Filter Dates for 2007-02-01 and 2007-02-02
 power_consumption_dataset <- power_consumption_dataset[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

 png("plot2.png", width=480, height=480)

 ## Plot 2
 plot(x = power_consumption_dataset$dateTime
      , y = power_consumption_dataset$Global_active_power
      , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
