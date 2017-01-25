

EmissionVehicleBaltimore <- inner_join(EmissionsBaltimore, SCCVehicle, by= "SCC")
EmissionVehicleLA        <- inner_join(EmissionsLA, SCCVehicle, by= "SCC")

totalEmissionVehicleBaltimore <- EmissionVehicleBaltimore %>% group_by(year)%>% 
                                summarise(sumEmissions= sum(Emissions))%>%
                                mutate(city = "Baltimore")

totalEmissionVehicleLA <- EmissionVehicleLA %>% group_by(year)%>% 
                                summarise(sumEmissions= sum(Emissions))%>%
                                mutate(city = "LA")

combineEmissionVehicle <- bind_rows(totalEmissionVehicleBaltimore, totalEmissionVehicleLA)

q3 <- ggplot(data = combineEmissionVehicle, aes(x=year, y=sumEmissions , group=city, fill = city))+
        geom_bar(stat="identity")+
        facet_grid(.~city)+
        guides(fill=FALSE)+
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
        labs(title="PM2.5 motor vehicle emissions in Baltimore and LA") 

print(q3)


dev.copy(png, file ='plot6.png', width=480, height=480, units='px')  
dev.off()


# plot6 <- function() {
#         NEI <- readRDS("summarySCC_PM25.rds")
#         png("plot6.png", width=480, height=480)
#         NEI <- NEI[NEI$fips==c("24510","06037") & NEI$type == "ON-ROAD",]
#         data <- aggregate(list(PM25 = NEI$Emissions), by=list(Year = NEI$year, Fips = NEI$fips), FUN=sum)
#         p <- qplot(Year, PM25, data = data, colour = Fips)
#         print(p)
#         dev.off()
# }


#library(gridExtra)
#grid.arrange(q3,q4,ncol=2, top = "Total PM2.5 emissions from motor vehicle in Baltimore and LA")
