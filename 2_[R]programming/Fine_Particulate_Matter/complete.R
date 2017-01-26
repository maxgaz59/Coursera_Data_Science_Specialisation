complete<- function(directory, id=1:332){
        completeCases<-data.frame()
        for (i in id){
                getDir<- paste(directory, "/", sprintf( "%03d",i), ".csv", sep = "")
                specdata<-read.csv(file = getDir, sep=",", header = TRUE)
                good<- complete.cases(specdata)
                specdataClean<-specdata[good,]
                nobs<-nrow(specdataClean)
                completeCases<- rbind(completeCases, c(i, nobs))
        }
        colnames(completeCases)<-c("id", "nobs")
        completeCases        
        }