library(dplyr)
library(lubridate)

setwd("C:/Users/party/Documents/Coursera/Exploratory Data Analysis/household_power")

#read text file as data table
householdDT <- data.table::fread(input = "household_power_consumption.txt"
                                 , na.strings="?"
)

householdDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

householdDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
householdDT <- householdDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = householdDT[, dateTime]
     , y = householdDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()