
library(sqldf)

library(dplyr)


dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dataZipFilePath<-"./household_power_consumption.zip"

download.file(dataURL, dataZipFilePath)

#Extract zip file 
unzip(dataZipFilePath)


dates<-c("'1/2/2007'", "'01/02/2007'", "'2/2/2007'", "'02/02/2007'")

sql<-"select * from file where Date in "

sqld<-paste("(",paste(dates,collapse=","),")")





finalSql<-paste(sql,sqld)

df <- read.csv.sql("household_power_consumption.txt", finalSql, sep=";")

colnames(df)

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

globalActivePower<-as.numeric(df$Global_active_power)


datetime <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")


voltage<-as.numeric(df$Voltage)


plot(datetime, voltage, type="l", xlab="datetime", ylab="Global Active Power (kilowatts)")



subMeter1<-as.numeric(df$Sub_metering_1)

#datetime <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

plot(datetime, subMeter1, type="l", xlab="", ylab="Energy sub metering")

subMeter2<-as.numeric(df$Sub_metering_2)

lines(datetime,subMeter2, col="Red")

subMeter3<-as.numeric(df$Sub_metering_3)

lines(datetime,subMeter3, col="Blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


globalReactivePower<-as.numeric(df$Global_reactive_power)

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global Reactive Power ")

dev.off()



