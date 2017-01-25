library(dplyr)
library(ggplot2)

setwd("~/[coursera]DataSciences/DataScienceSpecialisation/4_Exploratory/ExData_Plotting2/")

fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileName <- "FNEI_data.zip"


## Check if the file exists or needs to be downloaded
if(!file.exists(fileName)){
        download.file(fileURL, destfile = fileName, method="curl")
        unzip(fileName)
}


## Check if both data table are in the global environment.
## Read them all once.
if(!exists("NEI", envir = environment())){
        print("NEI does not exist")
        NEI <- readRDS("summarySCC_PM25.rds")
        NEI <- tbl_df(NEI)
}

if(!exists("SCC", envir = environment())){
        print("SCC does not exist")
        SCC <- readRDS("Source_Classification_Code.rds")
        SCC <- tbl_df(SCC)
}
##############
## Useful Databases for the assignement:
## EmissionBaltimore: subset NEI to get only Baltimore related data
## EmissionLA: subset NEI to get only LA related data
## SCCVehicle: subset SCC by Vehicle
##############



NEI <- NEI %>% mutate(year = as.factor(year))
EmissionsBaltimore <- NEI %>% filter(fips == "24510")
EmissionsLA <- NEI %>% filter(fips == "06037")
SCC <- SCC %>% mutate(SCC = as.character(SCC))    
SCCVehicle<- SCC %>% filter(grepl('Vehicles', EI.Sector )) %>% droplevels()
                                













##########
#Example of left_join
##########
# a<-tbl_df(data.frame(v1=c(1,2,2, 1, 3), v2= c(4,5,6, 7,8)))
# b<-tbl_df(data.frame(v1=c(1,2), v3=c("h","f")))
# c<- inner_join(a,b,by="v1") #left_join

