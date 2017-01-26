


SCCcoal<- SCC %>% filter(grepl('Coal', EI.Sector )) %>% droplevels()

EmissionCoal <- inner_join(NEI, SCCcoal, by= "SCC")

totalEmissionCoalType <- EmissionCoal %>% group_by(year, type) %>% 
                        summarise(sumEmissions= sum(Emissions)) 



q1 <- ggplot(data = totalEmissionCoalType, aes(x=year, y=sumEmissions , group=type, fill = type))+
        geom_bar(stat="identity")+
        facet_grid( .~ type)+
        labs(x="year", y=expression("Total PM2.5 Emission from Coal (Tons)")) + 
        labs(title="Total PM2.5 emissions from Coal in USA") 

print(q1)

dev.copy(png, file ='plot4.png', width=480, height=480, units='px')  
dev.off()