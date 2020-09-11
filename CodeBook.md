---
title: "Code Book"
author: "LMeza"
date: "10 de septiembre de 2020"
output: html_document
---

## Code Book 

The data is taken from UCI HAR Dataset. This dataset provide the following variables for each activity:

- subject - ID of participant
- activity - ID of activity type
- Mean and standart deviation for the following features (other values are presented in initial dataset, but for this reasearch only these parameters were used)
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag


The following data transformations were conducted to form a tidy dataset:


## How script works
Script involves the following stages:

Note: **It's supposed that archive is downloaded and extracted to the working directory.**


1. Load features.txt and activities.txt

2. Load the training dataset dataset:
a. Firstly loads the measurements from X_train.txt as a data frame
b. For these data frame column names are updated to be more user friendly using features description loaded on the previous stage. (STEP 4: Appropriately label the data set with descriptive variable names of Course Project
c. activity labels and subjects for measurements are also loaded from files train/y_train.txt and train/subject_train.txt and added to data frame as a separated columns.

Similar steps are made for test dataset and finally 2 rows of 2 data frames are merged together to form are data frame with complete data (STEP 1: Merge the training and the test sets to create one data set of assignment)

3. To extract measurements that involves only mean and standard deviation values script uses grep, that finds column names that includes "mean()" or "std()" (also columns activity and subject are added to filtered data frame, since they are important dimensions). After that all new data frame with only necessary columns is created. (STEP 2: Extract only the measurements on the mean and standard deviation for each measurement of assignment)

4. To provide descriptive values for activity labels a new variable "activitylabel" is added to dataset, that is a factor variable with levels mentioned in file activity_labels.txt (STEP 3: Use descriptive activity names to name the activities in the data set of assignment)

5. Creates a melted data frame using activity label and subject as ids, after that mean values for all variables are calculated grouped by activity and subject using groupby() function and tidy data frame is created. (STEP 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject)
