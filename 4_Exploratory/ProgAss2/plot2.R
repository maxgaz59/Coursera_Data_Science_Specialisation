

totalEmissionsBaltimore <- EmissionsBaltimore %>% group_by(Pollutant, year)%>%
                                summarise(sumEmissions=sum(Emissions))

barplot(totalEmissionsBaltimore$sumEmissions, ylab = "Total PM2.5 Emission (Tons)",
        xlab= "Year", names.arg = totalEmissionsBaltimore$year, 
        main = "Total PM2.5 emissions for Baltimore City")

dev.copy(png, file ='plot2.png', width=480, height=480, units='px')  
dev.off()