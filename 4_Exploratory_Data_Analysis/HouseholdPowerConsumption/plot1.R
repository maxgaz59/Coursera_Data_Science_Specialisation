source("getData.R")

makePlot1<-function(){
        with(data2days, hist(Global_active_power, col= "red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
}


par(mfcol=c(1,1))
makePlot1()
dev.copy(png, file ='plot1.png', width=480, height=480, units='px')  
dev.off()