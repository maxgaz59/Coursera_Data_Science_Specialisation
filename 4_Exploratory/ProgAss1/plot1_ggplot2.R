source("getData.R")
library(ggplot2)

makePlot1<-function(){
        q<-ggplot(data=data2days, aes(data2days$Global_active_power)) +
                geom_histogram(col="black", fill="red", alpha = 1, bins=11) + 
                labs(title="Global Active Power") +
                labs(x="Global Active Power (kilowatts)", y="Frequency") 
               # xlim(c(18,52)) + 
                #ylim(c(0,30))
        
        print(q)
}


par(mfcol=c(1,1))
makePlot1()
dev.copy(png, file ='plot1.png', width=480, height=480, units='px')  
dev.off()



makePlot2<-function(){
        q <- ggplot(data=data2days, aes(x=1:nrow(data2days), y=data2days$Global_active_power))+
         geom_line()+
         labs(x=" ", y="Global active power (kw)") +
         scale_x_date(name = data2days$Date)
        print(q)
}

par(mfcol=c(1,1))
makePlot2()
dev.copy(png, file ='plot2.png', width=480, height=480, units='px')  
dev.off()

# 
# makePlot3<-function(){
#         qplot(1:nrow(data2days), data2days$Sub_metering_1, col ="black", type='l', xaxt  ="n", xlab = "", ylab= "Energy sub metering")
#         lines(1:nrow(data2days), data2days$Sub_metering_2, col ="red")
#         lines(1:nrow(data2days), data2days$Sub_metering_3, col ="blue")
#         axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
# }
# 
# par(mfcol=c(1,1))
# makePlot3()
# legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
# dev.copy(png, file ='plot3.png', width=480, height=480, units='px')  
# dev.off()
# 
# 
# 
# makePlot4 <- function(){
#         par(mfcol=c(2,2),  mar = c(4, 4, 2, 1))
#         makePlot2()
#         makePlot3()
#         legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", y.intersp =0.5, cex=1)
#         plot(1:nrow(data2days), data2days$Voltage, type='l', xaxt  ="n", xlab = "datetime", ylab= "Voltage")
#         axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
#         plot(1:nrow(data2days), data2days$Global_reactive_power, type='l', xaxt  ="n", xlab = "datetime", ylab= "Global_reactive_power")
#         axis(1, at=c(1, nrow(data2days)/2+1, nrow(data2days)), labels = c("Thu", "Fri", "Sat"))
# }
# makePlot4()
# dev.copy(png, file ='plot4.png', width=480, height=480, units='px')  
# dev.off()