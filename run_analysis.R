### Project Script for Getting and Cleaning Data Course in Coursera
###
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for
###    each measurement.
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
### 5. From the data set in step 4, creates a second, independent tidy data
###    set with the average of each variable for each activity and each subject.


# Load the required libraries
library("data.table")
library("reshape2")

cleanData <- function() {

    ## features and Activities
    activityLabels <- fread("UCI HAR Dataset/activity_labels.txt",
                            col.names = c("classLabels", "activityName"))
    features <- fread("UCI HAR Dataset/features.txt",
                      col.names = c("index", "featureNames"))
    featureNamesList <- features[,featureNames]
    indexFeaturesRequired <- grep("(mean|std)\\(\\)", featureNamesList)
    featureList <- features[indexFeaturesRequired, featureNames]
    

    ## Clean Training Data
    trainData <- fread("UCI HAR Dataset/train/X_train.txt")
    trainData <- trainData[, indexFeaturesRequired, with = FALSE]
    data.table::setnames(trainData, colnames(trainData), featureList)
    trainActivities <- fread("UCI HAR Dataset/train/y_train.txt",
                             col.names = c("Activity"))
    trainSubjects <- fread("UCI HAR Dataset/train/subject_train.txt",
                           col.names = c("SubjectNum"))
    trainData <- cbind(trainSubjects, trainActivities, trainData)

    ## Clean Test Data
    testData <- fread("UCI HAR Dataset/test/X_test.txt")
    testData <- testData[, indexFeaturesRequired, with = FALSE]
    data.table::setnames(testData, colnames(testData), featureList)
    testActivities <- fread("UCI HAR Dataset/test/Y_test.txt",
                            col.names = c("Activity"))
    testSubjects <- fread("UCI HAR Dataset/test/subject_test.txt",
                          col.names = c("SubjectNum"))
    testData <- cbind(testSubjects, testActivities, testData)
    
    ## Merge Training and Test Data 
    mergedData <- rbind(trainData, testData)
  
    ## Convert classLabels to descriptive activityNames 
    mergedData[["Activity"]] <- factor(mergedData[, Activity], 
                                       levels = activityLabels[["classLabels"]], 
                                       labels = activityLabels[["activityName"]])
    
    mergedData[["SubjectNum"]] <- as.factor(mergedData[, SubjectNum])
    
    ## get the mean of the measured data per activity per subject
    mergedData <- reshape2::melt(data = mergedData,
                                 id = c("SubjectNum", "Activity"))
    mergedData <- reshape2::dcast(data = mergedData,
                                  SubjectNum + Activity ~ variable,
                                  fun.aggregate = mean)
    ## write the final data to a file
    write.table(mergedData, file = "tidy_data.txt", quote=FALSE, sep = ",", row.names=FALSE)
}

cleanData()
