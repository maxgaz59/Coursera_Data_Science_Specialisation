# library(plyr)
# library(dplyr)
# library(lazyeval)
# setwd("DataSciences/DataScienceSpecialisation/2_[R]programming/ProgAss3/")

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        outcome_df <- tbl_df(read.csv("outcome-of-care-measures.csv", colClasses = "character"))
        outcome <- gsub(" ", "_", outcome)
        newNames<- c("hospital", "state", "heart_attack", "heart_failure", "pneumonia")
        
        
        
        ## Check that state and outcome are valid
        if(sum(mapply(is.element, newNames, outcome)) == 0) { stop("invalid outcome")}
        
        
        ## Return hospital name in that state with lowest 30-day death
        oldNames<- c("Hospital.Name",
                     "State",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        
        
        temp <- outcome_df %>%
                mutate_each(funs(replace(.,. =="Not Available", NA)))%>%
                rename_(.dots=setNames(oldNames, newNames))%>%
                select_(.dots=c("hospital", "state", outcome))%>%
                na.omit()%>%
                mutate_each_(funs(as.numeric), outcome)%>%
                arrange_(.dots = c("state",outcome, "hospital"))%>%
                group_by(state)%>%
                #mutate_(rank= interp(~frank(x, ties.method = "dense"), x=as.name(outcome)))
                mutate_(rank= interp(~row_number(x), x=as.name(outcome)))
                

  
        
        
        if (num == "best") chooseR<- function(x) return(1)
        else if (num == "worst") chooseR<- function(x) return(max(x))
        else chooseR<- function(x) return(num)
        
        labelState<- data.frame(state = unique(temp$state),stringsAsFactors = FALSE)
        temp1 <- temp %>%  filter(rank == chooseR(rank)) %>%
                   full_join(., labelState, by ="state")%>%
                   select(hospital, state)%>%
                   arrange(state)
        temp1<-data.frame(temp1)
        return(temp1) 
}  

# > r <- rankall("pneumonia", "worst")
# > as.character(subset(r, state == "NJ")$hospital)
# [1] "BERGEN REGIONAL MEDICAL CENTER"
# > r <- rankall("heart attack", 4)
# > as.character(subset(r, state == "HI")$hospital)
# [1] "CASTLE MEDICAL CENTER"
# > r <- rankall("heart failure", 10)
# > as.character(subset(r, state == "NV")$hospital)
# [1] "RENOWN SOUTH MEADOWS MEDICAL CENTER"

####################

# if (num == "best") num<-1
# #if (num == "worst") num<- temp$rank
#  if (num == "worst") {
#           num<- temp %>% filter(rank == max(rank))%>%
#                                   ungroup()%>%
#                                   select(rank)
#          
#  }
# num<-rep(num$rank, num$rank)
