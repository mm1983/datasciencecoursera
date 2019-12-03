# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file plot1.R, plot2.R, etc. that constructs the corresponding plot, 
# i.e. code in plot1.R constructs the plot1.png plot. 
# Your code file should include code for reading the data so that the plot can be fully reproduced. 
# You must also include the code that creates the PNG file.
# Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)

library(lubridate)
library(dplyr)
library(tidyr)

# Read in a loop to determine what chunk to bulk read for analysis and subsetting. 
for (i in 0:2000) {
    toSkip <- i*24*60 + 1
    data <- read.table("household_power_consumption.txt",sep=";", header=F, nrows=1, skip = toSkip)
    # print(c(i,as.character(data[1,1])))
    if(dmy(data[1,1]) >= ymd("2007-02-01")) {
        save_i <- i
        break
    }
}

# read a chunk that defintely contains the dates of interest. 
data <- read.table("household_power_consumption.txt",sep=";",header=F,nrows=3*24*60, skip = (save_i-1)*24*60)
colnames(data) <- colnames(read.table("household_power_consumption.txt",sep=";",header=T, nrows=1))

# Filter the exact dates of interest
data_cleaned <- filter(data,grepl("^[12]/2/2007",data$Date) ) 

# convert the two columns to a POSIXct date time class by combining them and add it to the df
datetime <- dmy_hms(paste(data_cleaned$Date,sep="_",data_cleaned$Time))
data_cleaned <- cbind(data_cleaned,datetime)

png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar=c(4,4,2,2))
with(data_cleaned, plot(datetime,Global_active_power,ylab="Global Active Power",type="l",xlab=""))

with(data_cleaned,plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

with(data_cleaned, plot(datetime,Sub_metering_1,ylab="Energy sub metering",type="l",xlab="",lty=1,lwd=1))
with(data_cleaned, lines(datetime,Sub_metering_2,col="red",lty=1,lwd=1))
with(data_cleaned, lines(datetime,Sub_metering_3,col="blue",lty=1,lwd=1))
text=c("Sub metering_1","Sub metering_2","Sub metering_3")
legend("topright",col = c("black","red","blue"), lty = c(1,1,1), lwd = c(1,1,1), bty="n", legend=text)

with(data_cleaned,plot(datetime,Global_reactive_power,type="l",xlab="datetime"))

dev.off()
