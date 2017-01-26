
library(dplyr)

setwd("~")
setwd("./[coursera]DataSciences/DataScienceSpecialisation/4_Exploratory/ProgAss1_ExploratoryData")
#rm(list=ls())
fileURL  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.zip"



if (!file.exists(fileName)){
        download.file(fileURL, destfile = fileName, method="curl")
        unzip(fileName)
}

# colClasses could have also been used to modify the type (from factor to stg else).
if(!exists("dataset", envir = environment())){
        print("does not exist")
        dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"))
        dataset <- na.omit(dataset)
        dataset <- tbl_df(dataset)
        print(object.size(dataset))
}

if(!exists("data2days", envir = environment())){
        data2days <- dataset %>% 
                mutate(Date = as.Date(Date, "%d/%m/%Y"))%>%
                filter(Date >="2007-02-01", Date <"2007-02-03") 
}

#######
## For the legend with date: get directly the day.
##################################################
#datetime <- strptime(paste(power$Date, power$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


#rm(dataset)
#png(filename='plot1.png', width=480, height=480, units='px')


