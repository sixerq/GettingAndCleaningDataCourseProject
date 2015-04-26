##GETTING THE DATA

##Download the file and put the file in the data folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

##Unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##Unzipped files are in the folderUCI HAR Dataset. Get the list of the files
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

##READING DATA and RELATED FILES

##ACTIVITY consists of "Y_train.txt" and Y_test.txt"
##SUBJECT consists of “subject_train.txt” and subject_test.txt"
##FEATURES consists of “X_train.txt” and “X_test.txt”
##Names of Variable FEATURES comes from “features.txt”
##Levels of Variable ACTIVITY comes from “activity_labels.txt”
##Thus, ACTIVITY, SUBJECT and FEATURES will be used for the descriptive variable names in data frame

##Read the ACTIVITY files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

##Read the SUBJECT files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

##Read the FEATURES files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

##Properties of the variables
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)

##1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET

##Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

##Set names to the variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

##Merge columns to get the data frame DATA for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

##2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

##Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

##Subset the data frame DATA by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

##Check the structures of the data frame DATA
str(Data)

##3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

##Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

##The activity field in DATA is originally of numeric type. 
##We need to change its type to character so that it can accept activity names. 
##The activity names are taken from metadata activityLabels.
Data$activity <- as.character(Data$activity)
for (i in 1:6){
        Data$activity[Data$activity == i] <- as.character(activityLabels[i,2])
}

##Factorize Variable ACTIVITY in the data frame DATA using descriptive activity names
Data$activity <- as.factor(Data$activity)

##Check
head(Data$activity,30)

##4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

##Names of FeAtures will labeled using descriptive variable names.

##prefix t is replaced by time
##Acc is replaced by Accelerometer
##Gyro is replaced by Gyroscope
##prefix f is replaced by frequency
##Mag is replaced by Magnitude
##BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
##check
names(Data)

##5. FROM THE DATA SET IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
