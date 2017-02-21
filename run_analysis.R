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
trainingSubjects <- read.table(file.path(database, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(database, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(database, "train", "y_train.txt"))
testSubjects <- read.table(file.path(database, "test", "subject_test.txt"))
testValues <- read.table(file.path(database, "test", "X_test.txt"))
testActivity <- read.table(file.path(database, "test", "y_test.txt"))
features <- read.table(file.path(database, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(database, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")
Activity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)
rm(trainingSubjects, trainingValues, trainingActivity, 
   testSubjects, testValues, testActivity)
colnames(Activity) <- c("subject", features[, 2], "activity")
columnsToKeep <- grepl("subject|activity|mean|std", colnames(Activity))
Activity <- Activity[, columnsToKeep]
Activity$activity <- factor(Activity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])
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
ActivityColumns <- gsub("BodyBody", "Body", ActivityColumns)
colnames(Activity) <- ActivityColumns
ActivityColumns
ActivityMeans <- Activity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(ActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
