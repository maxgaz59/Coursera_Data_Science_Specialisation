# v<- unique(dmDF$State)
# mapply(best,v, rep("heart attack", length(v)))
# na.omit
# iris %>% mutate_each(funs(replace(., . > 5, NA)), -Species)
# iris %>% rename_(.dots=setNames(names(.), tolower(gsub("\\.", "_", names(.)))))


best <- function(state, outcome) {
        ## Read outcome data
        outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcome <- gsub(" ", "_", outcome)
        newNames<- c("heart_attack", "heart_failure", "pneumonia")
        oldNames<- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                     "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
        
        temp <- outcome_df %>%
                rename_(.dots=setNames(oldNames, newNames))%>%
                select_(.dots=c("Hospital.Name", "State", newNames))
        
        temp<-tbl_df(temp)
        
       
        ## Check that state and outcome are valid
        if(!(state %in% temp$State)){
                stop("invalid state")
        }else if(!(outcome %in% newNames)){ 
                stop("invalid outcome")
        }
        
        ## Return hospital name in that state with lowest 30-day death
                
        temp <- temp%>%
                filter(State == state) %>% 
                select_(.dots=c("Hospital.Name", outcome))%>%
                mutate_each(funs(replace(.,. =="Not Available", NA)))%>%
                na.omit()%>%
                mutate_each_(funs(as.numeric), outcome)%>% 
                filter_(.dots = interp( ~(x== min(x, na.rm=TRUE)), x = as.name(outcome)))%>%
                arrange(Hospital.Name)
        return(as.character(temp[1,1])) 
        
}

# > best("NY", "pneumonia")
# [1] "MAIMONIDES MEDICAL CENTER"
# > best("AK", "pneumonia")
# [1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"
        
        
        ####################################################################################
## Check that state and outcome are valid
# if(sum(mapply(is.element, outcome_df$State, state)) == 0) {stop("invalid state")}
# if(sum(mapply(is.element, newNames, outcome)) == 0) { stop("invalid outcome")}



       
        # if (outcome == vecOutcome[1]){
        #         temp<- dmDF %>% filter(State == state) %>% 
        #                 select(Hospital.Name , DMHeartAttack)%>%
        #                 filter(DMHeartAttack == min(DMHeartAttack, na.rm=TRUE))%>%
        #                 select(Hospital.Name)
        # }else if (outcome == vecOutcome[2]){
        #         temp<- dmDF %>% filter(State == state) %>% 
        #                 select(Hospital.Name, DMHeartFailure)%>%
        #                 filter(DMHeartFailure == min(DMHeartFailure, na.rm=TRUE))%>%
        #                 select(Hospital.Name)
        # }else if (outcome == vecOutcome[3]){
        #         temp<- dmDF%>% filter(State == state) %>%
        #                 select(Hospital.Name, DMPneumonia)%>%
        #                 filter(DMPneumonia == min(DMPneumonia, na.rm=TRUE))%>%
        #                 select(Hospital.Name)
        #}
        
       
        # 
        # setnames(outcome_df, oldNames, newNames)
        
        
        ## rate
