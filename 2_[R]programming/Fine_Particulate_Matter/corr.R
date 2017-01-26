corr<- function(directory, threshold=0){
             corrVec<-c()
             completeVector<-complete(directory)   
             id<- completeVector[completeVector[,"nobs"]>threshold,"id"]
             for (i in id){
                        getDir<- paste(directory, "/", sprintf( "%03d",i), ".csv", sep = "")
                        specdata<-read.csv(file = getDir, sep=",", header = TRUE)
                        good<- complete.cases(specdata)
                        specdataClean<-specdata[good,]
                        corrVec<-cbind(corrVec,cor(specdataClean[,"sulfate"], specdataClean[,"nitrate"]))
             }
             as.vector(corrVec)
    }