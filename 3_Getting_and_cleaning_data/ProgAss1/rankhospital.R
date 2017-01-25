
rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        outcome_df <- tbl_df(read.csv("outcome-of-care-measures.csv", colClasses = "character"))
        outcome <- gsub(" ", "_", outcome)
        newNames<- c("heart_attack", "heart_failure", "pneumonia")
        
        
        
        ## Check that state and outcome are valid
        if(sum(mapply(is.element, outcome_df$State, state)) == 0) {stop("invalid state")}
        if(sum(mapply(is.element, newNames, outcome)) == 0) { stop("invalid outcome")}
        # 
        # if (!state %in% outcome_df[, "State"]) stop('invalid state')
        # if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) 
        #         stop('invalid outcome')
        # 
        ## Return hospital name in that state with lowest 30-day death
        oldNames<- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        
        
        temp <- outcome_df %>%
                mutate_each(funs(replace(.,. =="Not Available", NA)))%>%
                rename_(.dots=setNames(oldNames, newNames))%>%
                filter(State == state) %>% 
                select_(.dots=c("Hospital.Name", outcome))%>%
                na.omit()%>%
                mutate_each_(funs(as.numeric), outcome)%>% 
                select_(.dots=c("Hospital.Name", outcome))%>%
                arrange_(.dots = c(outcome, "Hospital.Name"))%>%
                mutate(rank=1:nrow(.))
        
        if (num == "best") num<-1
        if (num == "worst") num<-nrow(temp)
        
        
        temp <- temp %>% filter(rank ==  num)
        return(as.character(temp[1,1])) 
}      

# rankhospital("WA", "heart attack", 7)
# [1] "YAKIMA VALLEY MEMORIAL HOSPITAL"
# > rankhospital("TX", "pneumonia", 10)
# [1] "SETON SMITHVILLE REGIONAL HOSPITAL"
