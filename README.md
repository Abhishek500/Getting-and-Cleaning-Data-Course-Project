# Getting-and-Cleaning-Data-Course-Project
The R script, run_analysis.R is used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps:

    Download and unzip source data if it doesn't exist.
    Read data.
    Merge the training and the test sets to create one data set.
    Extract only the measurements on the mean and standard deviation for each measurement.
    Use descriptive activity names to name the activities in the data set.
    Appropriately label the data set with descriptive variable names.
    Create a second, independent tidy set with the average of each variable for each activity and each subject.
    Write the data set to the tidy_data.txt file.

The tidy_data.txt in this repository was created by running the run_analysis.R script using R version 3.3.1 (2017-02-21) on Windows 8 Pro 32-bit edition.

This script requires the dplyr package.
