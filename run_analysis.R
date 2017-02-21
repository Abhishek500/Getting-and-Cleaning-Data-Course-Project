## install required packages and get the data
library(dplyr)
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}
database <- "UCI HAR Dataset"
if (!file.exists(database)) {
  unzip(zipFile)
}

## read training and test data
trainingSubjects <- read.table(file.path(database, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(database, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(database, "train", "y_train.txt"))
testSubjects <- read.table(file.path(database, "test", "subject_test.txt"))
testValues <- read.table(file.path(database, "test", "X_test.txt"))
testActivity <- read.table(file.path(database, "test", "y_test.txt"))

## read features and activity labels
features <- read.table(file.path(database, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(database, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

## 1.Merges traning and test sets to create one data set.
Activity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)
colnames(Activity) <- c("subject", features[, 2], "activity")

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
columnsToKeep <- grepl("subject|activity|mean|std", colnames(Activity))
Activity <- Activity[, columnsToKeep]

## 3.Uses descriptive activity names to name the activities in the data set
Activity$activity <- factor(Activity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

## 4.Appropriately labels the data set with descriptive variable names. 
ActivityColumns <- colnames(Activity)
ActivityColumns <- gsub("[\\(\\)-]", "", ActivityColumns )
ActivityColumns <- gsub("^f", "frequencyDomain", ActivityColumns)
ActivityColumns <- gsub("^t", "timeDomain", ActivityColumns)
ActivityColumns <- gsub("Acc", "Accelerometer", ActivityColumns)
ActivityColumns <- gsub("Gyro", "Gyroscope", ActivityColumns)
ActivityColumns <- gsub("Mag", "Magnitude", ActivityColumns)
ActivityColumns <- gsub("Freq", "Frequency", ActivityColumns)
ActivityColumns <- gsub("mean", "Mean", ActivityColumns)
ActivityColumns <- gsub("std", "StandardDeviation", ActivityColumns)
colnames(Activity) <- ActivityColumns

## 5.From the data set in step 4, creates a second, independent tidy data set with the
##   average of each variable for each activity and each subject.
ActivityMeans <- Activity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(ActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

