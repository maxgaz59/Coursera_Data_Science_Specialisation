source("getData.R")


makePlot3<-function(){
        plot(1:nrow(data2days), data2days$Sub_metering_1, col ="black", type='l', xaxt  ="n", xlab = "", ylab= "Energy sub metering")
        lines(1:nrow(data2days), data2days$Sub_metering_2, col ="red")
        lines(1:nrow(data2days), data2days$Sub_metering_3, col ="blue")
        axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
}

par(mfcol=c(1,1))
makePlot3()
legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
dev.copy(png, file ='plot3.png', width=480, height=480, units='px')  
dev.off()
