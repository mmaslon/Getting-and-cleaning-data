#install required packages
install.packages("dplyr")
library(dplyr)

#create variable which contains path to working directory
path<-getwd()

#create variable specifying URL where the data is stored
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#create variable specifying file name for the dataset 
filename<-"dataset.zip"
#download dataset
if(!file.exists(path)) { dir.create(path) }
download.file(fileUrl,destfile = filename, method="curl")
#unzip and list the files, this requires the user to select the file when prompted
zipF<-file.choose()
outdir<-getwd()
unzip(zipF,exdir=outdir)
#Merge the training and the test sets to create one data set.
#read appropriate data sets
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
#X_test needs to be stacked with X_train
test_train<-rbind(X_test,X_train)
#add names to this first part of dataset using features.txt
features<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
names(test_train)<-features[,2]
names(test_train)
#stack Y_test and Y_train (containing name of activity),
test_train_labels<-rbind(Y_test, Y_train)
# stuck test and train subjects 
test_train_subjectes<-rbind(test_subject, train_subject)

#change data type in test_train_labels and subjects to int
test_train_subjectes[1]<-lapply(test_train_subjectes[1],as.numeric)
test_train_labels[1]<-lapply(test_train_labels[1],as.numeric)
#combine subjects, labels and the actual data
table_subjectes_labels<-cbind(test_train_subjectes,test_train_labels)
table<-cbind(table_subjectes_labels,test_train)
#add apropriate labels for first two columns
names(table)[1]<-paste("SubjectID")
names(table)[2]<-paste("ActivityID")
#extract appropriate data: only the measurements on the mean and standard deviation for each measurement.
keeps<-grepl("mean\\()|std()|ActivityID|SubjectID", names(table))
table_mean_std<-table[keeps]
#Use descriptive activity names to name the activities in the data set
#this is column 2 in table2
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING
#create vector with activity names, vector with activity IDs, and make dataframe of this
activity_names<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
activityID<-1:6
activityLabels<-data.frame(activity_names,activityID)
table_mean_std$ActivityID<-activityLabels[match(table_mean_std$ActivityID, activityLabels$activityID),1]
#create user friendly col names
replaceColNamePattern2 <- function(table_mean_std, pattern, replace){
  names(table_mean_std) <- gsub(pattern, replace, names(table_mean_std))
  table_mean_std
}
(table_mean_std <- replaceColNamePattern2(table_mean_std, "^t", "time"))
(table_mean_std <- replaceColNamePattern2(table_mean_std, "^f", "freq"))
(table_mean_std <- replaceColNamePattern2(table_mean_std, "\\()", ""))
(table_mean_std <- replaceColNamePattern2(table_mean_std, "\\-", ""))
(table_mean_std <- replaceColNamePattern2(table_mean_std, "mean", ".Mean"))
(table_mean_std <- replaceColNamePattern2(table_mean_std, "std", ".Std"))
#group by subject and activity and summarise_all
table_group<-group_by(table_mean_std, SubjectID, ActivityID)
tidy_data<-summarise_all(table_group, funs(mean))
#save the data
write.table(tidy_data, "tidyData.txt", row.name=FALSE)
