
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

globalActivePower<-as.numeric(df$Global_active_power)

datetime <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot2.png", width=480, height=480)

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()



