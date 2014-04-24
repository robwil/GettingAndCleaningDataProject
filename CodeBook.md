# Codebook: Wearable Computing Data Set
*by Rob Williams, April 2014*

## What is our data?

The data we are looking at here represents accelerometer and gyroscope 3-axial signal means/stdevs for 30 subjects who performed 6 different physical activities while wearing a smartphone. Each activity took a variable length of time, and so there are several observations per subject/activity combination which represent "samples" (at a constant rate of 50Hz) during their performing of that activity. The data set was cleaned and tidied so as to present all of this data in a single table. There is also a separate table provided which summarizes the data for each subject/activity combination across all samples taken for that activity.

## Raw data overview

This section briefly describes the raw data files.

The data directory has three main sections where files are stored.

In the root of the data directory are two files that are part of the data set (activity_labels.txt and features.txt). Activity_labels.txt maps the numbers 1-6 to the appropriate activities (e.g. Walking) that the subject was performing. Features.txt contains the column/variable names for the main data. There are two other text files, but these are meant to be read by humans to understand the data, and so not contain actual data.

The next two directories are the "test" and "train" directories. These both contain the same type of information, with slightly different filenames - representing whether they are part of the training subjects or actual test subjects. 70% of the subjects are represented in the training data set, while the remaining 30% are in the test data set.

Within these directories, there are three files. There is a file called subject_*.txt that contains the subject number for each observation row. There is a file called y_*.txt that contains the activity number for each observation row. Finally, there is a file called x_*.txt that contains the actual observations for each row - corresponding to all the features in the features.txt file.

These directories also contain an Inertial Signals sub-directory with raw data from the smartphone. For our purposes we did not need to deal with the raw inertial signal data.

Now, the raw data set contains 561 features (aka variables) for each observation. This data is described well in the "features_info.txt" of the raw data set, which describes their methodology. The following is an excerpt that explains the main idea:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

Note that for each of these conceptual variables, the raw data set includes several "results" that were found by taking functions such as mean, min, max, etc. on the data. For the purposes of this analysis, we are only concerned with the data resulting from the mean() and std() functions.

## Tidy data overview

### Data transformation steps

The following steps were taken to transform the raw data into the tidy data. More detail about these steps are covered in the comments of the R script (`run_analysis.R`) which actually performs these steps.

1. Read in the descriptor files which map the various columns and/or numbered codes to real meanings.

2. Read in the actual test and training data, adding column names to the data.

3. Merge the test and training data into one data set. Also, merge the descriptors so we know which subject and activity each observation belows to.

4. Extract only the column variables which contain mean() or stdev() information.

5. Summarize the resulting data by grouping by activity/subject and computing the mean.

6. Write the tidy data sets to CSV file.

### subjectActivityMeasurements.csv

This file contains all the measurements from both the test and training data, for every test subject and activity combination. After filtering the data to only include the means and stdev values, the amount of variables was reduced to 66. For each row, we also have 2 descriptive variables: the subjectCode (a number from 1 - 30) and the activityName.

**The decision was made to leave the variable names the same as the raw data source.** The reasoning for this is that the names were already human readable, for example "Body" and "Gravity", "Acc" for accelerometer, "Gyro" for gyroscope. The meaning of the "f" (fast-fourier transformation of the data) and the "mag" (magnitude using Euclidean norm) are concepts that are best left to the codebook, lest we get extremely long variable names.

The includes variables are as follows:

*  subjectCode 
*  activityName 
*  tBodyAcc-mean()-X 
*  tBodyAcc-mean()-Y 
*  tBodyAcc-mean()-Z 
*  tBodyAcc-std()-X 
*  tBodyAcc-std()-Y 
*  tBodyAcc-std()-Z 
*  tGravityAcc-mean()-X 
*  tGravityAcc-mean()-Y 
*  tGravityAcc-mean()-Z 
*  tGravityAcc-std()-X 
*  tGravityAcc-std()-Y 
*  tGravityAcc-std()-Z 
*  tBodyAccJerk-mean()-X 
*  tBodyAccJerk-mean()-Y 
*  tBodyAccJerk-mean()-Z 
*  tBodyAccJerk-std()-X 
*  tBodyAccJerk-std()-Y 
*  tBodyAccJerk-std()-Z 
*  tBodyGyro-mean()-X 
*  tBodyGyro-mean()-Y 
*  tBodyGyro-mean()-Z 
*  tBodyGyro-std()-X 
*  tBodyGyro-std()-Y 
*  tBodyGyro-std()-Z 
*  tBodyGyroJerk-mean()-X 
*  tBodyGyroJerk-mean()-Y 
*  tBodyGyroJerk-mean()-Z 
*  tBodyGyroJerk-std()-X 
*  tBodyGyroJerk-std()-Y 
*  tBodyGyroJerk-std()-Z 
*  tBodyAccMag-mean() 
*  tBodyAccMag-std() 
*  tGravityAccMag-mean() 
*  tGravityAccMag-std() 
*  tBodyAccJerkMag-mean() 
*  tBodyAccJerkMag-std() 
*  tBodyGyroMag-mean() 
*  tBodyGyroMag-std() 
*  tBodyGyroJerkMag-mean() 
*  tBodyGyroJerkMag-std() 
*  fBodyAcc-mean()-X 
*  fBodyAcc-mean()-Y 
*  fBodyAcc-mean()-Z 
*  fBodyAcc-std()-X 
*  fBodyAcc-std()-Y 
*  fBodyAcc-std()-Z 
*  fBodyAccJerk-mean()-X 
*  fBodyAccJerk-mean()-Y 
*  fBodyAccJerk-mean()-Z 
*  fBodyAccJerk-std()-X 
*  fBodyAccJerk-std()-Y 
*  fBodyAccJerk-std()-Z 
*  fBodyGyro-mean()-X 
*  fBodyGyro-mean()-Y 
*  fBodyGyro-mean()-Z 
*  fBodyGyro-std()-X 
*  fBodyGyro-std()-Y 
*  fBodyGyro-std()-Z 
*  fBodyAccMag-mean() 
*  fBodyAccMag-std() 
*  fBodyBodyAccJerkMag-mean() 
*  fBodyBodyAccJerkMag-std() 
*  fBodyBodyGyroMag-mean() 
*  fBodyBodyGyroMag-std() 
*  fBodyBodyGyroJerkMag-mean() 
*  fBodyBodyGyroJerkMag-std() 

### subjectActivitySummary.csv

This summary file was derived from the above tidy data output (subjectActivityMeasurements.csv). It simply contains the mean value for all 66 variables, when grouped by subject/activity pairs. Since there are 30 subjects and 6 activities, there are 180 observations in this summary table.