# GetAndCleanCoursera
This Repo is for the "Getting and Cleaning Data" course in Coursera

This contains a script (run_analysis.R) to:

1. Merges the training and the test sets to create one data set (mergedData).
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data (tidy_data.txt)
   set with the average of each variable for each activity (Activity, 6 activities) and 
   each subject (SubjectNum, 30 subjects) 
   
This script has been tested with RStudio

The data used was downloaded from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script needs this data to unzipped in the same directory as the script.
