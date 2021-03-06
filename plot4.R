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

setwd("C:/Users/Deepthi M N/Documents/GitHub/ExData_Plotting1")
windows()

is.na(data5$Sub_metering_1)<-data5$Sub_metering_1=="?"
is.na(data5$Sub_metering_2)<-data5$Sub_metering_2=="?"
is.na(data5$Sub_metering_3)<-data5$Sub_metering_3=="?"

data5[,"timestamp"]<-as.POSIXct(paste(data5$Date, data5$Time), format="%Y-%m-%d %H:%M:%S")

plotcol <- c("black","red","blue")

newData<-data5[,7:11]
newData[,1]<-as.character(newData[,1])
newData[,1]<-as.numeric(newData[,1])
newData[,2]<-as.character(newData[,2])
newData[,2]<-as.numeric(newData[,2])
newData[,3]<-as.character(newData[,3])
newData[,3]<-as.numeric(newData[,3])

data5[,"timestamp"]<-as.POSIXct(paste(data5$Date, data5$Time), format="%Y-%m-%d %H:%M:%S")
data5$Voltage<-as.character(data5$Voltage)
data5$Voltage<-as.numeric(data5$Voltage)

data6<-data5[,c(5,10)]
data6<-data6[complete.cases(data6),]
data6$Voltage<-as.character(data6$Voltage)
data6$Voltage<-as.numeric(data6$Voltage)

par(mfcol=c(2,2))
plot(data5$TimeStamp, data5$Global_active_power,type="l",xlab=" ", ylab="Global Active Power (kilowatts)")

plot(newData$timestamp,newData$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(newData$timestamp,newData$Sub_metering_2,type="l",col="red")
lines(newData$timestamp,newData$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),col=plotcol,lwd=2,y.intersp=0.65,cex=0.7,lty=1,bty="n")

plot(data5$timestamp,as.numeric(data5$Voltage),type="l",xlab="datetime",ylab="Voltage")


plot(as.numeric(data5$Global_reactive_power)*2/1000~data5$timestamp,data5,type="l",xlab="",ylab="Global Reactive Power (kilowatts)")
dev.copy(png,file="plot4.png")
dev.off()
