library(rvest)
library(dplyr)
library(ggplot2)


setwd("~/[coursera]DataSciences/DataScienceSpecialisation/5_Reproducible_research/RepData_PeerAssessment2/")

fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
fileName <- "StormData.csv.bz2"

if(!file.exists(fileName)){
        print("download")
        download.file(fileURL,  destfile = fileName, method="curl")
}

if(!(exists("dataset", envir = environment()))){
        print("dataset does not exist")
        dataset <- tbl_df(read.csv(fileName, header = TRUE, sep=','))
}

facMul<- c(1,0,0,0,1,10, 10^2, 10^3, 10^4, 10^5, 10^6, 10^7, 10^8, 10^9, 10^2, 10^2, 10^3, 10^6, 10^6)
facMulCrop<- c(1,0,1, 10^2, 10^9, 10^3, 10^3, 10^6, 10^6)


data <- dataset %>% 
        select(EVTYPE, BGN_DATE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)

facMul<- c(1,0,0,0,1,10, 10^2, 10^3, 10^4, 10^5, 10^6, 10^7, 10^8, 10^9, 10^2, 10^2, 10^3, 10^6, 10^6)
levels(data$PROPDMGEXP) <- facMul
facMulCrop<- c(1,0,1, 10^2, 10^9, 10^3, 10^3, 10^6, 10^6)
levels(data$CROPDMGEXP) <- facMulCrop

data <- data%>%
        mutate(POPHEALTH = FATALITIES + INJURIES)%>%
        mutate(DMEXPENSE = PROPDMG*as.numeric(levels(PROPDMGEXP))[PROPDMGEXP] + CROPDMG*as.numeric(levels(PROPDMGEXP))[PROPDMGEXP])%>%
        filter(POPHEALTH >0 | DMEXPENSE >0)

dataEVTYPE <- data%>%
        mutate(EVTYPE = toupper(EVTYPE))%>%
        mutate(EVTYPE = gsub("[[:space:][:punct:]+]", " ", EVTYPE))%>%
        mutate(EVTYPE = gsub("TSTM|TH*UND*ER*[A-Z]*RMW*|THUNDERSTROM|THUDERSTORM",
                    "THUNDERSTORM", EVTYPE))%>%
        mutate(EVTYPE =gsub("THUNDERSTORM.*|SEVERE THUNDERSTORM", "THUNDERSTORM", EVTYPE))%>%
        mutate(EVTYPE =gsub("TORN.*", "TORNADO", EVTYPE))%>%
        mutate(EVTYPE =gsub("^BLIZZARD.*", "BLIZZARD", EVTYPE))%>%
        mutate(EVTYPE =gsub("EXCESSIVE|EXCESSIVELY|EXTREMELY|RECORD", "EXTREME",EVTYPE))%>%
        mutate(EVTYPE =gsub("DROUGHT|^EXTREME.*HEAT.*|^HEAT.*", "EXTREME HEAT", EVTYPE))%>%
        mutate(EVTYPE =gsub(".*FLOOD.*", "FLOODING", EVTYPE))%>%
        mutate(EVTYPE =gsub("ICE STORM.*|WINTER STORM.*", "ICE/WINTER STORM", EVTYPE))%>%
        mutate(EVTYPE =gsub("WILD.*FIRE.*", "WILD FIRE", EVTYPE))%>%
        mutate(EVTYPE =gsub("CURRENTS", "CURRENT", EVTYPE))%>%
        mutate(EVTYPE =gsub(".*WIND.*CHILL.*|^COLD", "EXTREME COLD", EVTYPE))%>%
        mutate(EVTYPE =gsub("^HIGH WINDS|STRONG.*WIND|^WIND", "HIGH WIND", EVTYPE))%>%
        mutate(EVTYPE =gsub("^HURRICANE.*", "HURRICANE", EVTYPE))%>%
        mutate(EVTYPE =gsub("DENSE FOG", "FOG", EVTYPE))%>%
        mutate(EVTYPE =gsub(".*HIGH.*WIND.*", "HIGH WIND", EVTYPE))%>%
        mutate(EVTYPE =gsub("^LIGHTN.*", "LIGHTNING", EVTYPE))%>%
        mutate(EVTYPE =gsub("^SNOW.*", "HEAVY SNOW", EVTYPE))


glimpse(dataEVTYPE)

dataPopHealth <- dataEVTYPE %>% 
        group_by(EVTYPE)%>%
        summarise(TOTALPOPHEALTH = sum(POPHEALTH, na.rm=TRUE))%>%
        arrange(desc(TOTALPOPHEALTH))%>%
        mutate(EVTYPE = reorder(EVTYPE, -TOTALPOPHEALTH))



dataECO <- dataEVTYPE %>% 
        group_by(EVTYPE)%>%
        summarise(TOTALDMEXPENSE = sum(DMEXPENSE, na.rm=TRUE))%>%
        arrange(desc(TOTALDMEXPENSE))%>%
        mutate(EVTYPE = reorder(EVTYPE, -TOTALDMEXPENSE))



plot1 <- ggplot(slice(dataPopHealth, 1:10), aes(x=EVTYPE,y=TOTALPOPHEALTH))+
        geom_bar(position = "dodge",stat="identity")+
        labs(x="Event Type", y="Injuries+Fatalities") + 
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title="Top ten catastrophic events in USA from 1950 to Today") 
print(plot1)


plot2 <- ggplot(slice(dataECO, 1:10), aes(x=EVTYPE,y=TOTALDMEXPENSE))+
        geom_bar(position = "dodge",stat="identity")+
        labs(x="Event Type", y="Property + Crop damages") + 
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title="Top ten catastrophic events in USA from 1950 to Today") 
print(plot2)

#######
##SPLIT BGN_DATE AND CONVERT TO DATE
######
#library(tidyr)
#separate(col= BGN_DATE, into=c("BGN_DATE", "BGN_TIME") ,  sep=" ", remove=TRUE)
#No need to separate the column here since the %H:%M:%S is always 0:00:00.
#The conversion using strptime automatically remove the hours when it is this format.


# dataPopHealthRecent <- dataEVTYPE %>% 
#         mutate(BGN_DATE = strptime(BGN_DATE, format = "%m/%d/%Y %H:%M:%S") %>% as.character())%>%
#         filter(BGN_DATE >= "1999-11-25")%>%
#         group_by(EVTYPE)%>%
#         summarise(TOTALPOPHEALTH = sum(POPHEALTH, na.rm=TRUE))%>%
#         arrange(desc(TOTALPOPHEALTH))

##########
##USING THE GREPL FUNCTION
###########

# dataPopHealthRecent <- dataEVTYPE %>% 
#          filter(grepl("199|20[^/]", BGN_DATE))%>%
#          group_by(EVTYPE)%>%
#          summarise(TOTALPOPHEALTH = sum(POPHEALTH, na.rm=TRUE))%>%
#          arrange(desc(TOTALPOPHEALTH))


###
##COLLECT THE EVENT FROM THE DROPDOWN LIST ON THE WEBSITE
#######
# storms <- read_html("https://www.ncdc.noaa.gov/stormevents/choosedates.jsp?statefips=-999%2CALL")
# eventType <- data.frame(event_id=storms %>% html_nodes("#eventType option") %>% html_attr("value"),
#                         event_name=storms %>% html_nodes("#eventType option") %>% html_text(),
#                         stringsAsFactors=FALSE)



