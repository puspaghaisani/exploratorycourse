library(dplyr)
library(lubridate)

setwd("C:/Users/party/Documents/Coursera/Exploratory Data Analysis/household_power")

#read text file as data table
householdDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

householdDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

householdDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

householdDT <- householdDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(householdDT[, dateTime], householdDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(householdDT[, dateTime], householdDT[, Sub_metering_2],col="red")
lines(householdDT[, dateTime], householdDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
