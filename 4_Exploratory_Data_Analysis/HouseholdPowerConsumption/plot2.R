source("getData.R")


makePlot2<-function(){
        plot(1:nrow(data2days), data2days$Global_active_power, type='l', xaxt  ="n", xlab = "", ylab= "Global Active Power (kilowatts)")
        axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
}

par(mfcol=c(1,1))
makePlot2()
dev.copy(png, file ='plot2.png', width=480, height=480, units='px')  
dev.off()