---
title: "README.md"
output: html_document
---

Project Assignment
==================================================================

Getting and Cleaning Data Course Project - Cousera

Student: Paola Castaño

Dataset provided by:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description of the Data:
==================================================================

The datasets come from the experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,  3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.Full description of the dataset is available at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Project Assignment - Cleaning Data and Results:
======================================

The funtion "run_analysis" loads the raw data into R, and cleans the dataset by following the next steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with 
the average of each variable for each activity and each subject.

This code produces an independent tidy data set with the average of each variable 
(group by activity and subject) which is called Averages_Data.txt. A detailed description for the 
abbreviations in the name variables is provided in the file 'abbreviations_info.md'

This Project Assignment includes the following files:
=========================================

- 'README.md'

- 'run_analysis.R': Script that contains the function to clean data and produce the independent tidy dataset.

- 'CodeBook.md' : Data Dictionary explaining the abbreviations and the units for the variables used 

- 'abbreviations_info.md' : A description for the abbreviations in the name variables


Notes: 
======
- Please, once you download the tidy independent dataset (Averages_Data.txt) 
created by running the function "run_analysis", run the following code to visualize properly
        
        data <- read.table("./Averages_Data.txt", header = TRUE)
        View(data)
        
- The run_analysis script assumes that the data zip file has been downloaded and unzipped already.
If not, please run the next code to get the raw data. (Remember to set destfile according to your working directory)
        
        urlfile<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(urlfile,destfile,method = curl)
        unzip(destfile,list = TRUE)

- Features in the raw dat were normalized and bounded within [-1,1], so the variables in the 
tidy data: Averages_Data keep with the same characteristic 