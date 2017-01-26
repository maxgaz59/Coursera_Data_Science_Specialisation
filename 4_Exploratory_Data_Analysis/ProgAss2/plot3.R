


totalEmissionsBaltimoreType <- EmissionsBaltimore %>% 
                                mutate(type= as.factor(type))%>%
                                group_by(Pollutant, year, type)%>%
                                summarise(sumEmissions=sum(Emissions))


q <- ggplot(data = totalEmissionsBaltimoreType, aes(x=year, y=sumEmissions ,fill=type)) +
        geom_bar(stat="identity") +
        guides(fill=FALSE)+
        facet_grid(.~type)+
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
        labs(title= "Total PM2.5 emissions for Baltimore City by type") 



# q <- ggplot(data = totalEmissionsBaltimoreType, aes(x=year, y=sum, group=type, colour = type))+
#         geom_line()+
#         labs(title="Total emissions from 1999-2008 for Baltimore City") 

print(q)

dev.copy(png, file ='plot3.png', width=480, height=480, units='px')  
dev.off()