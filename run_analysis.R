library(dplyr)
## Setting the working directory containing the data sets
setwd("C:/Users/muhammad.sadiq/Documents/UCI HAR Dataset/")

##Merges the training and the test sets to create one data set.
x_train<-read.table("train/X_train.txt")
x_test<-read.table("test/X_test.txt")
x_data<-rbind(x_train,x_test)

y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_data<-rbind(y_train,y_test)


##Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read.table("features.txt")
mean_sd_measurement<-grep("-(mean|std)\\(\\)",features[,2])

##Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
y_data[,1]= activities[y_data[,1],2]
names(y_data) <- "activity"

##Appropriately labels the data set with descriptive variable names.
x_data<-x_data[mean_sd_measurement]
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject_data <- rbind(subject_train, subject_test)
names(subject_data) <- "subject"


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- cbind(x_data, y_data, subject_data)
cols<-length(tidy_data)-2
averages_data <- ddply(tidy_data, .(subject, activity), function(x) colMeans(x[, 1:cols]))
write.table(averages_data, "averages_data.txt", row.name=TRUE)

