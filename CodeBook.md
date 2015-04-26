#The Code Book
##Overview
This describes the variables, the data, and any transformations or work performed to clean up the data

##Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##Getting The Data
- Download, unzip and get the list of the files. 
- See README.txt for the detailed information of the data set.
 - test/X_test.txt
 - test/y_test.txt
 - train/subject_train.txt
 - train/X_train.txt
 - train/y_train.txt

##Reading The Data
**Activity**,**Subject** and **Features** are the descriptive variable names in the data frame
-Read data from the files into the variables
-Read the properties and structures of the variables

##Step 1. Merges the training and the test sets to create one data set
- Concatenate the data tables by rows
- Set names to variables
- Merge columns to get the data frame

##Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
- Subset Name of Features by measurements on the mean and standard deviation
- Subset the data frame by seleted names of Features
- Check the structures of the data frame

##Step 3. Uses descriptive activity names to name the activities in the data set
- Read descriptive activity names from “activity_labels.txt”
- Variable needs to be factored in the data frame

##Step 4. Appropriately labels the data set with descriptive variable names
- Label features using descriptive variable names

##Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each
activity and each subject
- Independent tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 4.

