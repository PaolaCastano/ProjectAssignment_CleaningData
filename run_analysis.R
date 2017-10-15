## Funtion run_analysis that performs the next steps:
## 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.
##    
##    By Paola Castaño

#The run_analysis script assumes that the data zip file has been downloaded and unzipped already.
#If not, please run the next code to get the raw data. (Remember to set destfile according to your working directory)
        
        # urlfile<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        # download.file(urlfile,destfile,method = curl)
        # unzip(destfile,list = TRUE)

#Load packages into the sesion
library(dplyr)
library(data.table)

run_analysis<-function(){

        #Read features, activity labels and subjects  
        features <- read.table("./features.txt",header = FALSE)
        activity_label <- read.table ("./activity_labels.txt", header = FALSE)
        train_subject <- read.table ("./train/subject_train.txt", header = FALSE)
        test_subject <- read.table("./test/subject_test.txt", header = FALSE)
        
        #Read train dataset
        train_data <- read.table("./train/X_train.txt", header = FALSE)
        train_label <- read.table ("./train/y_train.txt", header = FALSE)
        
        #Read test dataset
        test_data <- read.table ("./test/X_test.txt", header = FALSE)
        test_label <- read.table ("./test/y_test.txt", header = FALSE)
        
        #Check if the two dataset have the same rectangular shape
        if(ncol(train_data)!=ncol(test_data)){
                return("The two datasets have different number of columns")
        }
        
        ## Task 1: Merge the training and the test sets to create one data set.
        #Merge training and test data. I´m merging training and test data, by data, labels, and subjects
        #datasets individually, so far. I´ll combine them after tidying up. 
        total_data <- rbind(train_data,test_data)
        total_label <- rbind(train_label,test_label)
        total_subject <- rbind(train_subject,test_subject)
        
        ## Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        #Look for column numbers and names from features where description has mean or std in it
        col_nums <- grep("mean|std",features[,2])
        col_names <- grep("mean|std",features[,2],value = TRUE)
    
        #Ignore special characteres in col_names, and correct 
        #BodyBody that is a typographical error. It should be "Body" (Leonard Greski - Mentor).
        col_names <- gsub("[()-]","",col_names)
        col_names <- gsub("BodyBody","Body",col_names)
        
        #Select the requiered columns 
        total_data <- total_data %>% select(col_nums)
        
        ## Task 3: Use descriptive activity names to name the activities in the data set
        # change the integer labels with text labels
        total_label <- activity_label[match(total_label[,1],activity_label[,1]),2]
        
        # Merge observations and labels. This is actually the merge dataset requiered in task 1.
        total_set <- cbind(total_data,total_label,total_subject)
        
        ## Task 4: Appropriately labels the data set with descriptive variable names.
        # Give descriptive names to variables.
        names(total_set) <- c(col_names,"activitylabel","subject")
        
        ## Task 5: From the data set in step 4, creates a second, independent tidy data set with 
        ## the average of each variable for each activity and each subject.
        averages <- total_set %>% group_by(activitylabel,subject) %>% summarize_all(funs(mean))
        write.table(averages, "Averages_Data.txt", row.names = FALSE)
        
        #Uncomment lines to load and view the resulting tidy dataset
        # data <- read.table("./Averages_Data.txt", header = TRUE)
        # View(data)
}