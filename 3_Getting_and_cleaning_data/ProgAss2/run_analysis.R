library(plyr)
library(dplyr)
library(lazyeval)

## 30 volunteers -> 70% in the train & 30% in the test
##
##'features.txt': List of all features.
##'activity_labels.txt': Links the class labels with their activity name.
##'train/X_train.txt': Training set.
##'train/y_train.txt': Training labels.
##'test/X_test.txt': Test set.
##'test/y_test.txt': Test labels.
##'train/subject_train.txt': Each row identifies the subject who performed 
##      the activity for each window sample. Its range is from 1 to 30. 
## 
## 'features.txt' -> the names of the variables
##
## 'activity_label.txt' <-> 'y_test.txt / y_train.txt'
## relates the labels in y_test and y_train to the activity name
##
## 'subject_train.txt'/ 'subject_test.txt' <-> 'x_test.txt / x_train.txt'
## relate the obs. in x_train / x_test to the volunteer label.

setwd("~")
setwd("DataSciences/DataScienceSpecialisation/2_[R]programming/data/")
fileURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "HumanRecognition.zip"
fileDir <- "UCI HAR Dataset"

if (!file.exists(fileName)){
        download.file(fileURL, destfile = fileName, method="curl")
        unzip(fileName)
}

## Reading the data and store in data.frame
## Name the variables in x_test and x_train with the character contained in features.
## Name the variables in activity_labels, y_test, y_train to have a common name (key) to merge them easily.

setwd(fileDir)

features        <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", col.names = c("activitylabels", "activitynames"))
subject_test    <- read.table("test/subject_test.txt", col.names ="volunteer")
x_test          <- read.table("test/X_test.txt", col.names = features$V2) 
y_test          <- read.table("test/y_test.txt", col.names ="activitylabels")
subject_train   <- read.table("train/subject_train.txt", col.names ="volunteer")
x_train         <- read.table("train/X_train.txt", col.names = features$V2)
y_train         <- read.table("train/y_train.txt", col.names ="activitylabels")


## Merges the training and the test sets to create one data set
allData         <- rbind(x_test, x_train)
allSubject      <- rbind(subject_test, subject_train)
allTestLabels   <- rbind(y_test, y_train)


## Removing unnessecary data frame from the global environnement
#rm(features,x_test, x_train, subject_test, subject_train, y_test, y_train)

## Join allTestLabels with activity_labels to get the name of the activity
## and select only the column associated to the names.
allTestLabels   <- allTestLabels %>% 
                        left_join(., activity_labels,by ="activitylabels") %>%
                        select(activitynames)

##  Create the tidy set. Cleaning the names, selecting only mean and std and
## joining allTestLabels and allSubject

allDataTidy     <- allData %>% select(matches('[.]mean|[.]std'))
oldnames        <- names(allDataTidy)
newnames        <- gsub("[.]mean", "Mean", oldnames)
newnames        <- gsub("[.]std", "Std", newnames)
newnames        <- gsub("[.]", "", newnames)
allDataTidy     <- allDataTidy %>% 
                        rename_(.dots = setNames(oldnames, newnames))%>%
                        bind_cols(allTestLabels,.) %>%
                        bind_cols(allSubject,.)%>%
                        group_by(activitynames, volunteer)%>%
                        summarise_each(funs(mean(., na.rm=TRUE)))

write.table(allDataTidy, "allDataTidy_mean.txt", row.names = FALSE, quote = FALSE)


                        
                

