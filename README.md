# Getting and Cleaning Data Project
*by Rob Williams, April 2014*

The purpose of this project was to demonstrate my ability to take a raw, freely available data set from the Internet and transform it into a "tidy" data set. For the purposes of this project, a tidy data set is defined as follows:

1. Each variable that is measured should be in one column
2. Each observation of that variable should be in one row
3. There should be one table for each "kind" of variable
4. If there are multiple tables, there should be a column that allows them to be linked

Source (and more information): [https://github.com/jtleek/datasharing](https://github.com/jtleek/datasharing)

### The Data

The data for this project comes from the UCI (University of California Irvine) Machine Learning Repository. Specifically, the data can be accessed at this link: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

To guard against possible modification of the data set at the original source and to ensure reproducibility, the data as of April 2014 has been snapshot at the following URL: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### File overview

This project repository consists of several files.

* README.md - the file you are currently reading, which describes how the other files fit together
* subjectActivityMeasurements.csv - the tidy data set that contains the mean/stdev measurements for several variables collected while subjects performed various physical activities
* subjectActivitySummary.csv - summarization of subjectActivityMeasurements, such that each variable is averaged after being grouped by subject and activity
* CodeBook.md - describes the tidy data sets, and how they were derived from the raw data set
* run_analysis.R - the R script which was used to create the tidy data sets from the raw files

**Note:** It is assumed that the [above linked ZIP file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is downloaded and extracted, and that the "UCI HAR Dataset" directory is copied into the R working directory and renamed to "data". If those steps are taken, the above run_analysis.R file should produce the same tidy data sets that have been included.

**Note 2:** These R scripts were developed and tested on a Windows 7 computer using R version 3.0.3 (2014-03-06), platform x86_64-w64-mingw32. While R is fairly portable, there may be some incompatibilities with alternate versions of R.