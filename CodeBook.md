This code book summarizes the resulting data fields in tidy.txt which is a text file, containing space-separated values.
The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables. 

Variables

Each row contains, for a given subject and activity, 79 averaged signal measurements.
Identifiers

    subject

    Subject identifier, integer, ranges from 1 to 30.

    activity

    Activity identifier, string with 6 possible values:
        WALKING: subject was walking
        WALKING_UPSTAIRS: subject was walking upstairs
        WALKING_DOWNSTAIRS: subject was walking downstairs
        SITTING: subject was sitting
        STANDING: subject was standing
        LAYING: subject was laying

Average of measurements

All measurements are floating-point values, normalised and bounded within [-1,1].
The measurements are classified in two domains:

    Time-domain signals (variables prefixed by timeDomain), resulting from the capture of accelerometer and gyroscope raw signals in X, Y and Z directions.

    Frequency-domain signals (variables prefixed by frequencyDomain), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals in X, Y and Z directions.

Transformations 

The zip file containing the source data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The following transformations were applied to the source data:

    The training and test sets were merged to create one data set.
    The measurements on the mean and standard deviation  were extracted for each measurement, and the others were discarded.
    The activity identifiers were replaced with descriptive activity names.
    The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to                					timeDomainBodyAccelerometerMeanX)
    From the data set in step 4, the final data set was created with the average of each variable for each activity and each   	 	 	 	 subject.

The collection of the source data and the transformations listed above were implemented by the run_analysis.R R script
