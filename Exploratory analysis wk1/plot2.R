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

# convert the two columns to a POSIXct date time class by combining them
datetime <- dmy_hms(paste(data_cleaned$Date,sep="_",data_cleaned$Time))

# make the plot
png(filename = "Plot2.png", width = 480, height = 480)
plot(datetime,data_cleaned$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xlab="")
dev.off()

