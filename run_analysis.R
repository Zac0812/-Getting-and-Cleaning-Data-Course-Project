
#Clean current enviroment 
rm(list = ls())

#load library
library(tidyverse)
library(reshape2)


#load files

#reading features and activity data

#List of all features and activities
features <- read.table("./UCI HAR Dataset/features.txt")
#Links the class labels with their activity name.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")



#read training data set and subjects
train <- read.table("./UCI HAR Dataset/train/X_train.txt") #features data
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") #activity labels
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subjects
#work on the training data set, renaming columns, adding activities and subjects
colnames(train) <- features$V2
train$activity <- y_train$V1
train$subject <- factor(subject_train$V1)


#read testing data set and subjects
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#work on the testing data set, renaming columns, adding activities and subjects
colnames(test) <- features$V2
test$activity <- y_test$V1
test$subject <- factor(subject_test$V1)


#merge train and test sets (STEP 1)
dataset <- rbind(test, train) 

#clean current enviroment except our marge dataset
rm(list = ls()[!(ls()== "dataset")]) 


#filter column names (STEP 2)
column_names <- colnames(dataset)
column_names_filtered<- grep("mean\\(|std\\(|activity|subjec",column_names, value = TRUE)


# column_names_filtered
dataset_filtered <- dataset[, column_names_filtered] 

#View(dataset_filtered)
#adding descriptive values for activity labels (STEP 3)
dataset_filtered$activitylabel <- factor(dataset_filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


dataset_melt<- gather(dataset_filtered,key = "variable", value = "value", -c("activity","subject","activitylabel") )
dataset_tidy<- group_by(dataset_melt, activitylabel,subject,variable) %>% summarize(mean = mean(value)) %>% 
  spread(variable,mean)



#creating a tidy dataset file  
write.table(dataset_tidy, file = "tidydataset.txt", row.names = FALSE)
#write.csv(dataset_tidy, file = "tidydataset2.csv", row.names = FALSE)


