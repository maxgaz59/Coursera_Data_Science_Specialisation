#CodeBook

This code book describes the processing required to create the resulting tidy data set
as well as the variables in this data set.

## The R script
Here are the steps performed by the R-script (run_analysis.R):

  1. Set the working directory
  2.  Download the zip file
  3. Unzip the file
  4. Read the .txt files containing the data and set variable names
  5.  Merge the training and the test sets to create three data sets: allData, allSubject          and allTestLabels
  6.  Set descriptive activity names
  7.  Clean variable names, select only mean and standard deviation for each              measurement and create one single tidy data set.
  8.   Compute the average of each variable for each activity and each subject.
  9. Store the data frame in the file *'allDataTidy_mean.txt'*.
 
 
## The variables
More information about the features is available in 'features_info.txt' available along with the data at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
In particular we only used the set of variables arising from the computation of the 

* mean(): Mean value
* std(): Standard deviation

They are

* volunteer 
* activitynames 
* tBodyAccMeanX 
* tBodyAccMeanY 
* tBodyAccMeanZ 
* tBodyAccStdX 
* tBodyAccStdY 
* tBodyAccStdZ 
* tGravityAccMeanX 
* tGravityAccMeanY 
* tGravityAccMeanZ 
* tGravityAccStdX 
* tGravityAccStdY 
* tGravityAccStdZ 
* tBodyAccJerkMeanX 
* tBodyAccJerkMeanY 
* tBodyAccJerkMeanZ 
* tBodyAccJerkStdX
* tBodyAccJerkStdY 
* tBodyAccJerkStdZ 
* tBodyGyroMeanX 
* tBodyGyroMeanY 
* tBodyGyroMeanZ 
* tBodyGyroStdX 
* tBodyGyroStdY 
* tBodyGyroStdZ 
* tBodyGyroJerkMeanX 
* tBodyGyroJerkMeanY 
* tBodyGyroJerkMeanZ 
* tBodyGyroJerkStdX 
* tBodyGyroJerkStdY 
* tBodyGyroJerkStdZ 
* tBodyAccMagMean 
* tBodyAccMagStd 
* tGravityAccMagMean 
* tGravityAccMagStd 
* tBodyAccJerkMagMean 
* tBodyAccJerkMagStd 
* tBodyGyroMagMean 
* tBodyGyroMagStd 
* tBodyGyroJerkMagMean 
* tBodyGyroJerkMagStd 
* fBodyAccMeanX 
* fBodyAccMeanY 
* fBodyAccMeanZ 
* fBodyAccStdX 
* fBodyAccStdY 
* fBodyAccStdZ 
* fBodyAccMeanFreqX 
* fBodyAccMeanFreqY 
* fBodyAccMeanFreqZ 
* fBodyAccJerkMeanX 
* fBodyAccJerkMeanY 
* fBodyAccJerkMeanZ 
* fBodyAccJerkStdX 
* fBodyAccJerkStdY 
* fBodyAccJerkStdZ 
* fBodyAccJerkMeanFreqX 
* fBodyAccJerkMeanFreqY 
* fBodyAccJerkMeanFreqZ 
* fBodyGyroMeanX 
* fBodyGyroMeanY 
* fBodyGyroMeanZ 
* fBodyGyroStdX 
* fBodyGyroStdY 
* fBodyGyroStdZ 
* fBodyGyroMeanFreqX 
* fBodyGyroMeanFreqY 
* fBodyGyroMeanFreqZ 
* fBodyAccMagMean 
* fBodyAccMagStd 
* fBodyAccMagMeanFreq 
* fBodyBodyAccJerkMagMean 
* fBodyBodyAccJerkMagStd 
* fBodyBodyAccJerkMagMeanFreq 
* fBodyBodyGyroMagMean 
* fBodyBodyGyroMagStd 
* fBodyBodyGyroMagMeanFreq 
* fBodyBodyGyroJerkMagMean 
* fBodyBodyGyroJerkMagStd 
* fBodyBodyGyroJerkMagMeanFreq

  