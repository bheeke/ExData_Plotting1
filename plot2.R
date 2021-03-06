## Make sure necessary packages are installed and loaded
## install.packages("dplyr")
## library(dplyr)
## install.packages("lubridate")
## library(lubridate)

## Read in source file but only observations/rows where date range is Feb 1 2007 through Feb 2 2007 and omit NA values
   data <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",stringsAsFactors=FALSE, na.strings = "?")
   data <- na.omit(data)

## Combine Date and Time columns, then remove time column
   data$Date <- paste(data$Date,data$Time)
   data2 <- select(data, -Time)

## Set Date range parameters
   Date1<-as.Date("2007-02-01")  
   Date2<-as.Date("2007-02-03")


## Convert date variable to POSIXct date class, then
## Filter data based on date range parameters, then 
## Convert feature variables to numbers
   data2$Date <- strptime(data2$Date, "%d/%m/%Y %H:%M")  
   data2$Date <- as.POSIXct(data2$Date)
   data3 <- filter(data2,(data2$Date>=Date1 & data2$Date<Date2))
   data3[,2:8] <- lapply(data3[,2:8],as.numeric)


## Create day of week variable against date field with lubridate package
## Turn on PNG graphic device to successfully save file in legible format
## Plot data and save output/copy to PNG file in local working directory
## Turn off active graphic device and return output to screen
   data4 <- mutate(data3,day_of_week = wday(data3$Date,label=TRUE))
   png(file="plot2.png",width=480,height=480)
   with(data4, plot(Date,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab  = ""))
   dev.off()
