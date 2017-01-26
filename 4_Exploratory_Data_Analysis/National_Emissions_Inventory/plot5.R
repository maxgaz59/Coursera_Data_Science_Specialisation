

EmissionVehicleBaltimore <- inner_join(EmissionsBaltimore, SCCVehicle, by= "SCC")

totalEmissionVehicleBaltimore <- EmissionVehicleBaltimore %>% group_by(year, type)%>% 
        summarise(sumEmissions= sum(Emissions))

q2<-ggplot(data = totalEmissionVehicleBaltimore, aes(x=year, y=sumEmissions , group=type, fill = type))+
        geom_bar(stat="identity")+
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
        labs(title="Total PM2.5 emissions from motor vehicle in Baltimore")  

print(q2)

dev.copy(png, file ='plot5.png', width=480, height=480, units='px')  
dev.off()




# plot5 <- function() {
#         NEI <- readRDS("summarySCC_PM25.rds")
#         png("plot5.png", width=480, height=480)
#         NEI <- NEI[NEI$fips=="24510" & NEI$type == "ON-ROAD" ,]
#         data <- aggregate(list(PM25 = NEI$Emissions), by=list(Year = NEI$year), FUN=sum)
#         p <- qplot(Year, PM25, data = data)
#         print(p)
#         dev.off()
# }
