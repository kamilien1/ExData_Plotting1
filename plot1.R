## Plot 1: Global Active Power, kW, Frequency Histogram

# Author: Kamil Bojanczyk
# Coursera Exploratory Data Analysis Project 1

## Information ## 
# Computer type: Mac
# file URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# NOTE: You must download the file from the url, unzip it, and place it in the current
# working directory. /NOTE
# unzipped file name: household_power_consumption.txt
# Data date range to use: 2007-02-01 to 2007-02-02
# Output: png of 480x480 pixels

## Memory Required ##
# Motivation: http://stackoverflow.com/questions/25674221/predict-memory-usage-in-r
# memory required = no. of column * no. of rows * 8 bytes/numeric
# 2,075,259 rows and 9 columns in this dataset 
# 149418648 bytes or **149mb** of memory required


## Column Classes and Data Information ##
# 1 Date: Date in format dd/mm/yyyy
# 2 Time: time in format hh:mm:ss
# 3 Global_active_power: household global minute-averaged active power (in kilowatt)
# 4 Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5 Voltage: minute-averaged voltage (in volt)
# 6 Global_intensity: household global minute-averaged current intensity (in ampere)
# 7 Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# 8 Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# 9 Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


### Code ### 

## Read file, rename column headers, "?" values as NA
## Please read above to download and extract file to currrent working directory
filename<- "household_power_consumption.txt"
col_names <- c('date','time','active_power','reactive_power','voltage','intensity','sub1','sub2','sub3')
raw_file <- read.table(filename, header=T, sep=';', col.names = col_names,na.strings="?")

# downsize file by date range
my_format = "%d/%m/%Y"
date_low = "2007-02-01"
date_hi = "2007-02-02"

date_low_df <- raw_file[as.Date(raw_file$date,format=my_format) == date_low,]
date_hi_df <- raw_file[as.Date(raw_file$date,format=my_format) == date_hi,]

# DF is our data of interest for date range of date_low to date_hi
DF <- rbind(date_low_df,date_hi_df)

# create a new column datetime at the end that is of type POSIXct
# and holds date+time together
DF <- data.frame(DF,paste(DF$date,DF$time,sep=' '))
new_col_names <- c(col_names,"datetime")
colnames(DF) <- new_col_names

dt_format = "%d/%m/%Y %H:%M:%S"
DF$datetime <- strptime(DF$datetime, dt_format)


# plot and close out
plot.new()
png(filename='plot1.png',height=480,width=480, units='px',bg='white')
par(mfrow=c(1,1),mar=c(5,5,2,2))
hist(DF$active_power, col='red', main='Global Active Power', 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
