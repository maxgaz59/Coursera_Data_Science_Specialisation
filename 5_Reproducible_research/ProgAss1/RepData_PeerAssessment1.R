library(dplyr)
library(ggplot2)
setwd("~/[coursera]DataSciences/DataScienceSpecialisation/5_Reproducible_research/RepData_PeerAssessment1")
dataset <- tbl_df(read.csv("activity.csv", header= TRUE, sep = ","))
dataset <- dataset %>%
        mutate(date = as.Date(date,  "%Y-%m-%d"))%>%
        group_by(date)
                               

nbSteps_days <- summarise(dataset, numberOfSteps = sum(steps, na.rm=TRUE))
meanOfSteps <-  mean(nbSteps_days$numberOfSteps, na.rm=TRUE)
medianOfSteps <- median(nbSteps_days$numberOfSteps, na.rm=TRUE)

median <- paste("Median = ", as.character(medianOfSteps))
mean <- paste("Mean = ", as.character(meanOfSteps))


q <- ggplot(nbSteps_days, aes(numberOfSteps))+ geom_histogram(col="black", fill= NA, alpha = 1 ,bins =14, boundary = 0) + 
        geom_vline(aes(xintercept=medianOfSteps, color= median), linetype="dashed", size=1) +
        geom_vline(aes(xintercept=meanOfSteps,   color= mean), linetype="dashed", size=1) +
        labs(title="Number of Steps") +
        labs(x="Number of Steps per day", y="Frequency") + 
        xlim(c(0, 25000)) + 
        ylim(c(0,20))+
        # scale_shape_discrete(labels = c("DDD", "EEE"))
        scale_color_manual(name = "statistics", values = c("blue", "red"))
                                                             
                                                            
print(q)


mean_Interval <- dataset %>%  group_by(interval) %>%
        summarise(meanByInterval = mean(steps, na.rm= TRUE))

q1 <- ggplot(mean_Interval, aes(interval ,  mean_Interval$meanByInterval) )+geom_line()+
        labs(title="Average Steps by time interval") +
        labs(x="5 min time interval", y="Average number of steps")+
        xlim(c(0, 2400)) 
print(q1)


# index <- which(mean_Interval$meanByInterval == max(mean_Interval$meanByInterval))
# intervalMax <- mean_Interval$interval[index]

intervalMax <- mean_Interval %>% filter(meanByInterval == max(meanByInterval))

# locationOfNA <- complete.cases(dataset)
# nbOfNA       <- sum(!locationOfNA)
# nbNA_interval<- summarise(dataset, nbOfNAbyInterval = sum(is.na(steps)))
# fillNA <- mapply(rep, mean_Interval$meanByInterval, nbNA_interval$nbOfNAbyInterval)
# fillNA <- as.vector(fillNA)
#  
# dataset$steps[!locationOfNA] <- fillNA
# dataset <- dataset %>% ungroup(dataset) %>% group_by(date) %>%arrange(date)


dataset <- dataset %>% group_by(interval) %>%
        mutate(steps= replace(steps, is.na(steps), mean(steps, na.rm=TRUE)))%>%
        group_by(date)%>% arrange(date)


nbSteps_days_noNA <- summarise(dataset, numberOfSteps = sum(steps))
meanOfSteps_noNA   <-  mean(nbSteps_days_noNA$numberOfSteps)
medianOfSteps_noNA <- median(nbSteps_days_noNA$numberOfSteps)

 median_noNA <- paste("Median = ", as.character(medianOfSteps_noNA))
 mean_noNA  <- paste("Mean = ", as.character(meanOfSteps_noNA))

 q2 <- ggplot(nbSteps_days, aes(numberOfSteps))+ geom_histogram(col="black", fill= NA, alpha = 1 ,bins =14, boundary = 0) + 
         geom_vline(aes(xintercept=medianOfSteps_noNA, color= median_noNA ), linetype="dashed", size=1) +
         geom_vline(aes(xintercept=meanOfSteps_noNA,   color= mean_noNA ), linetype="dashed", size=1) +
         labs(title="Number of Steps") +
         labs(x="Number of Steps per day", y="Frequency") + 
        xlim(c(0, 25000)) + 
        ylim(c(0,20))+
       # scale_shape_discrete(labels = c("DDD", "EEE"))
        scale_color_manual(name = "statistics", values = c("blue", "red"))

print(q2)

whichWeekDays <- function(x){
        if (x  == "samedi" || x==  "dimanche"){
                   return("weekend")  
        }
        return("weekdays") 
}


dat <- dataset %>% group_by(date)%>% 
        summarise(nbdays = n()) %>% rowwise() %>% mutate(days=whichWeekDays(weekdays(date)))

whichDayType <- rep(dat$days, dat$nbdays)
dayType <- tbl_df(as.data.frame(whichDayType, stringsAsFactors = TRUE))

dataset <- bind_cols(dataset, dayType)
      

activityPattern<- dataset %>% group_by(interval, whichDayType) %>%
                summarise(mean = mean(steps)) 


q3 <- ggplot(data = activityPattern, aes(interval , mean)) +
        geom_line()+
        facet_grid(. ~ whichDayType )+
        labs(title="Average Steps by time interval and day type") +
        labs(x="5 min time interval", y="Average number of steps") 
print(q3)
# #######################
# time2 <-system.time({
# dat2 <- dataset %>% 
#         rowwise() %>%
#         mutate(whichDayType = whichWeekDays(weekdays(date)))%>%
#         mutate(whichDayType = as.factor(whichDayType))
# })

