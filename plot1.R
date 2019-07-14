library(dplyr)
library(lubridate)

setwd("C:/Users/party/Documents/Coursera/Exploratory Data Analysis/household_power")


#read text file as data table
householdDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

householdDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

householdDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter date 2007-02-01 and 2007-02-02
householdDT <- householdDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

# Plot 1
hist(householdDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()