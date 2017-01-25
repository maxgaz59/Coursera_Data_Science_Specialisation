source("getData.R")
source("plot2.R")
source("plot3.R")

makePlot4 <- function(){
        par(mfcol=c(2,2),  mar = c(4, 4, 2, 1))
        makePlot2()
        makePlot3()
        legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", y.intersp =0.5, cex=1)
        plot(1:nrow(data2days), data2days$Voltage, type='l', xaxt  ="n", xlab = "datetime", ylab= "Voltage")
        axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
        plot(1:nrow(data2days), data2days$Global_reactive_power, type='l', xaxt  ="n", xlab = "datetime", ylab= "Global_reactive_power")
        axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
}
makePlot4()
dev.copy(png, file ='plot4.png', width=480, height=480, units='px')  
dev.off()