pollutantmean<- function(directory, pollutant, id=1:332){
        cmean<-0
        vecMean<-c()
        for (i in id){
                getDir<- paste(directory, "/", sprintf( "%03d",i), ".csv", sep = "")
                specdata<-read.csv(file = getDir, sep=",", header = TRUE)
                #good<- complete.cases(specdata)
                #specdataClean<-specdata[good,pollutant]
                #bad<- is.na(specdata[,pollutant])
                #specdataClean<-specdata[!bad, pollutant]
                #x<-mean(specdataClean)
                vecMean<-c(vecMean,specdata[, pollutant])
                #x<-mean(specdata[, pollutant], na.rm= TRUE)
                #cmean<-cmean+x
        }
        mean(vecMean, na.rm= TRUE)
}