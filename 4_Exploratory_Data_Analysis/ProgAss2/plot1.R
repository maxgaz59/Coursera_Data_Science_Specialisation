

totalEmissions <- NEI %>% group_by(Pollutant, year) %>% 
                        summarise(sumEmissions=sum(Emissions))


barplot(totalEmissions$sumEmissions, ylab = "Total PM2.5 Emission (Tons)", xlab= "Year", 
                ylim = c(0,8*10^6), names.arg = totalEmissions$year,
                main="Total PM2.5 emissions in US")


dev.copy(png, file ='plot1.png', width=480, height=480, units='px')
dev.off()