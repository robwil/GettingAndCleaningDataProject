# run_analysis.R
# Data transformation script
# by Rob Williams, April 2014

# This file contains the necessary R functionality to transform
# the raw data (assumed to be downloaded and extracted to the ./data/ directory)
# into tidy data. More information about the raw and tidy data can be found
# in CodeBook.md.

###########################################################################
#
# First, read in the "descriptor" files which map the various columns
# and/or numbered codes to real meanings.
#
###########################################################################

# read activity labels file, whitespace separator, no header
activityLabels <- read.table("./data/activity_labels.txt", sep="", header=F)
# remove first column since rownames is already 1..6
activityLabels <- subset(activityLabels, select = c('V2'))
# give better column name to remaining column
colnames(activityLabels) <- c('activityName')

# read features file, strip first column, give second column useful name
features <- read.table("./data/features.txt", sep="", header=F)
features <- subset(features, select = c('V2'))
colnames(features) <- c('featureName')

# read file that maps training data rows to their activities
trainingActivities <- read.table("./data/train/y_train.txt", sep="", header=F)
colnames(trainingActivities) <- c('activityCode')

# read file that maps training data rows to their subjects
trainingSubjects <- read.table("./data/train/subject_train.txt", sep="", header=F)
colnames(trainingSubjects) <- c('subjectCode')

# read file that maps test data rows to their activities
testActivities <- read.table("./data/test/y_test.txt", sep="", header=F)
colnames(testActivities) <- c('activityCode')

# read file that maps test data rows to their subjects
testSubjects <- read.table("./data/test/subject_test.txt", sep="", header=F)
colnames(testSubjects) <- c('subjectCode')

###########################################################################
#
# Second, we read in the actual test and training data and clean as needed.
#
###########################################################################

# read training data (note this takes a non-trivial amount of time)
trainingData <- read.table("./data/train/x_train.txt", sep="", header=F, nrow=7352, comment.char="")
# add column names, from features.txt
colnames(trainingData) <- features[,1]

# read test data (note this takes a non-trivial amount of time)
testData <- read.table("./data/test/x_test.txt", sep="", header=F, nrow=2947, comment.char="")
# add column names, from features.txt
colnames(testData) <- features[,1]

###########################################################################
#
# Third, we merge the test and training data, along with the descriptive data.
# This puts all observations as well as all columns/variables together in one
# data frame which we can use for the next step.
#
###########################################################################

# augment training data with activity and subject labels
trainingData <- cbind(trainingSubjects, trainingActivities, trainingData)

# augment test data with activity and subject labels
testData <- cbind(testSubjects, testActivities, testData)

# append the two data sets
mergedData <- rbind(testData, trainingData)

# merge in the activity names
mergedData <- merge(mergedData, activityLabels, by.x="activityCode", by.y="row.names")

###########################################################################
#
# Fourth, extract only the columns which contain mean() or std() information.
# This completes the requirement of our tidy data.
#
###########################################################################

# Determine which columns to keep.
# we know we want subjectCode and activityName
colsToKeep <- c("subjectCode","activityName")

# Loop through each column name, add ones that have mean() or std() in them
# to the columns we are keeping
columns <- colnames(mergedData)
for(column in columns) {
  if(!is.na(grep("mean\\(\\)", column) == 1 || grep("std\\(\\)", column) == 1)) {
    colsToKeep = c(colsToKeep, column)
  }
}

tidyData <- subset(mergedData, select=colsToKeep)

###########################################################################
#
# Fifth, construct a summary of the subject/activity values by averaging
# after grouping by subject/activity.
#
###########################################################################

# Use psych library's describeBy to get mean (and many other summaries)
# for our data, broken into a data frame of lists.
library(psych)
aggregate <- describeBy(tidyData, list(tidyData$subjectCode, tidyData$activityName))

# Put this into a final dataframe by looping through each subject/activity combo
summaryData <- data.frame(matrix(nrow=180, ncol=ncol(tidyData)))
i <- 1
for(activityLabel in activityLabels[,1]) {
  j <- 1
  for(subjectCode in "1":"30") {
    # get data for a particular subject/activity combo
    means <- aggregate[[subjectCode, as.character(activityLabel)]][,"mean"]
    summaryData[(j-1)*6 + i, ] <- means
    j <- j+1
  }
  i <- i+1
}
columns <- colnames(tidyData)
columns[2] <- "activityCode"
colnames(summaryData) <- columns

# Final cleanup - sort and replace activityCode with activityName
library('plyr')
summaryData <- arrange(summaryData, subjectCode, activityCode)
summaryData$activityName <- activityLabels[summaryData$activityCode, 1]
finalSummaryData <- cbind(summaryData[,1], summaryData[,69], summaryData[,3:68])
colnames(finalSummaryData) <- c("subjectCode", "activityCode", colnames(finalSummaryData[,3:68]))

###########################################################################
#
# Finally, output the tidy data as csv
#
###########################################################################

write.csv(tidyData, "./subjectActivityMeasurements.csv")
write.csv(finalSummaryData, "./subjectActivitySummary.csv")