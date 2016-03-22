
## From main folder
library(dplyr)
library(stats)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
## From test folder
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
## From train folder
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
### Step 1. Merges the training and the test sets to create one data set.

## USE ARRANGE AND JOIN

subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
data <- rbind(x_train, x_test)
traintest <- c(rep("train", nrow(x_train)), rep("test", nrow(x_test)))
#can cbind traintest to something later

### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
findmean <- grepl("mean", features[ ,2])
findstd <- grepl("std", features[ ,2])
find <- findstd|findmean
newdata <- data[ ,find == TRUE]


### Step 3. Uses descriptive activity names to name the activities in the data set
activity_named <- merge(activity, activity_labels, all.x=TRUE)

### Step 4. Appropriately labels the data set with descriptive variable names.
newfeatures <- features[find == TRUE,]
names(newdata) <- newfeatures[ ,2]
names(data) <- features[ ,2]

### Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## USE DDPLY OR SAPPLY
names(subject) <- "subject"
names(activity_named) <- c("activitynum", "activity")
clean <- cbind(subject, activity_named, newdata, traintest)
tidymeans <- aggregate(clean[, 4:82], by=clean[c("subject", "activity")], FUN=mean)
head(tidymeans)

write.table(tidymeans, file="tidymeans.txt", row.name=FALSE)
