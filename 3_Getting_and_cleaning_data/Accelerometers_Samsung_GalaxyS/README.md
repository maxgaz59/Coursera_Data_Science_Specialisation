#README: Accelerometers_Samsung_GalaxyS

## The project

This project contains:

 * a tidy data set stored in **allDataTidy_mean.txt**
 * a script **run_analysis.R** for performing the analysis
 * a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called **CodeBook.md**


## The data set

The data were collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. The volunteers are split into two groups: 21 volunteers in train set & 9 in the test set.
The data set contains the following files

* features.txt : List of all 561 features. Names of variables
* activity_labels.txt : Labels and activity names.
* subject_test.txt / subject_train.txt: Each row identifies the subject who performed the activity for each window sample.
* x_test.txt : Test set.
* y_test.txt : Activity labels for the 'test' set.
* x_train.txt : Training set.
* y_train.txt : Activity labels for the 'training' set.

The raw datas were not used here.

## The R script
The code downloads the Samsung data in your working directory.
This script requires the following packages

* library(plyr)
* library(dplyr)
* library(lazyeval)

The output is stored in *'allDataTidy_mean.txt'* in the UCI HAR Dataset repository in your working directory.
You can read more about the script and the variables in the code book.
