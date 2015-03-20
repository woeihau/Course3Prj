---
title: "Getting and Cleaning Data - Course Project Mar 2015 - CodeBook"
author: "woeihau"
date: "Friday, March 20, 2015"
output: html_document
---

##Project Description
This is the code book that descributes variables, data, and any transformations or work that you performed to clean up the data.

###The data source
* **Original data**         : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* **Original description**  : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Data Set Information (Can be found in zip file too)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

###Step by step in my R script
1. Pre-processing
  + Create folder "Course3Prj" in base working directory if it is not created yet.
  + Download zip file from the mentioned website if it is not downloaded yet.
  + Unqip the file if it is not unzip yet.
2. Data Preparation
  + Load title from features text file
  + Load activity label and named it as "activityID" and "activityName"
  + Load training data (from x_train.txt)
  + Load training activity (from y_train.txt)
  + Load training subject (person) (from subject_train.txt)
  + Load test data (from x_test.txt)
  + Load test activity (from y_test.txt)
  + Load test subject (person) (from subject_test.txt)
3. Proceed with step 1 & 3 
  + (Step 1: Merges the training and the test sets to create one data set)
  + (Step 3: Uses descriptive activity names to name the activities in the data set)
4. Proceed with step 2
  + (Step 2: Extracts only the measurements on the mean and standard deviation for each measurement)
5. Proceed with step 4
  + (Step 4: Appropriately labels the data set with descriptive variable names)
  + *The following words are being translated accordingly*
  + *"(" to ""*
  + *")" to ""*
  + *"^t" to "Time"*
  + *"^f" to "Frequency"*
  + *"Acc" to "Acceleration"*
  + *"Mag" to "Magnitude"*
  + *"mean" to "Mean"*
  + *"Freq" to "Frequency"*
  + *"std" to "StandardDeviation"*
  + *"Mag" to "Magnitude"*
6. Proceed with step 5
  + (Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject)