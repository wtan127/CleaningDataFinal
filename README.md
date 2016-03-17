# CleaningDataFinal
Final project for Getting and Cleaning Data Coursera course

The UCI HAR Dataset contains data on 30 subjects performing 6 tasks: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, and Laying with an Samsung phone attached at the waist. Data is collected from the accelerometer and gyroscope: 3-axial linear acceleration, and 3-axial angular velocity.
The dataset has been split randomly such at 70% are in a training set and 30% are in a test set.

The UCI HAR Dataset is downloaded into the working directory. The folder contains the subfolder "test", "train", and the following text files: activity_labels, features, features_info, and README

# From the README.txt file:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The data contains the following:
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
- 

#First, we extract the following tables
## From main folder
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
## From test folder
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
### from Inertial Signals sub folder
body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
## From train folder
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
### from Inertial Signals sub folder
body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

##Criterias for assignment
### Step 1. Merges the training and the test sets to create one data set.
x_train has the 7352 rows with the 561 feature columns (labels in "features")
subject_train labels each of the subjects in the 7352 rows with numbers 1:30
y_train gives 7352 rows with the activity labelled 1:6

**Merge subject_train & subject_test; y_train & y_test, x_train & x_test**
USE ARRANGE(JOIN()) and make sure that there is train and test still included

subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
data <- rbind(x_train, x_test)

### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

The measurements are:
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

and within the angle()
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Mean and Stv are mean() and std() in the following format:
tBodyAcc-mean()-X
angle(X,gravityMean)

findmean <- grepl("mean", features[ ,2])
findstd <- grepl("std", features[ ,2])
find <- findstd|findmean
Returns logical vectors. the vector find combines the two

newdata <- data[ ,find == TRUE]

### Step 3. Uses descriptive activity names to name the activities in the data set
** change activity data to include the name of the actual activity**
USE GROUPING AND CHAINING?

### Step 4. Appropriately labels the data set with descriptive variable names.

newlabels <- features[find == TRUE, ]
names(newdata) <- newlabels[ ,2]
** merge in subject and activity data frames**
NOT DONE YET NOT DONE YET

### Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
USE DDPLY OR SAPPLY
NOT DONE YET NOT DONE YET
