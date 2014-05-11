
## Data import and cleaning - Start ##

# import data
data <- read.table("C:/Users/Deepthi M N/Documents/GitHub/ExData_Plotting1/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";")

# remove row 1 which is headers imported as data
data2<-data[-1,] 

# create a list of headers
headers <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# assign headers
names(data2)<- headers

# verify assignment of headers
head(data2)

# filter only for 2007-02-01 and 2007-02-02
data3 <- data2

data3$Date<-as.Date(as.character(data3$Date),"%d/%m/%Y")

mydates <- as.Date(c("2007-02-01","2007-02-02"))

data4 <- subset(data3, Date %in% mydates)
data5<-data4

data5[,"TimeStamp"]<- as.POSIXct(paste(data5$Date, data5$Time), format="%Y-%m-%d %H:%M:%S")
head(data5)


## Data import and cleaning - End ##

## Constucting plot - start ##

library(datasets)
library(lubridate)

data5$day <- wday(data5$Date, label=TRUE)

head(data5)

setwd("C:/Users/Deepthi M N/Documents/GitHub/ExData_Plotting1")
windows()
data5$Global_active_power <- as.character(data5$Global_active_power)
data5$Global_active_power <- as.numeric(data5$Global_active_power)


png(file = "plot2.png", bg = "transparent")
plot(data5$TimeStamp, data5$Global_active_power,type="l",xlab=" ", ylab="Global Active Power (kilowatts)")
dev.off()

## Constructing plot - end ##

