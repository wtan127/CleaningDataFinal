##Getting and Cleaning Data final project

```{r echo=TRUE}
library(dplyr)
library(stats)
```
First we download the data:
```{r echo=TRUE}
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
```

Step 1. Merges the training and the test sets to create one data set.
```{r echo=TRUE}
subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
data <- rbind(x_train, x_test)
traintest <- c(rep("train", nrow(x_train)), rep("test", nrow(x_test)))
```
Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
```{r echo=TRUE}
findmean <- grepl("mean", features[ ,2])
findstd <- grepl("std", features[ ,2])
find <- findstd|findmean
newdata <- data[ ,find == TRUE]
```
Step 3. Uses descriptive activity names to name the activities in the data set
```{r echo=TRUE}
activity_named <- merge(activity, activity_labels, all.x=TRUE)
```
Step 4. Appropriately labels the data set with descriptive variable names.
```{r echo=TRUE}
newfeatures <- features[find == TRUE,]
names(newdata) <- newfeatures[ ,2]
names(data) <- features[ ,2]
```
Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```{r echo=TRUE}
names(subject) <- "subject"
names(activity_named) <- c("activitynum", "activity")
clean <- cbind(subject, activity_named, newdata, traintest)
tidymeans <- aggregate(clean[, 4:82], by=clean[c("subject", "activity")], FUN=mean)
head(tidymeans)
```
Writing to table:
```{r echo=TRUE}
write.table(tidymeans, file="tidymeans.txt", row.name=FALSE)
```

Sample of the tidy data:
subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
1      10   LAYING         0.2769771       -0.01703330        -0.1108735       -0.3919863
2      12   LAYING         0.2736087       -0.01833720        -0.1066491       -0.5839622
3      13   LAYING         0.2758959       -0.01765048        -0.1091353       -0.6248445
4      18   LAYING         0.2763242       -0.01728315        -0.1081123       -0.6946169
5      20   LAYING         0.2684258       -0.01759130        -0.1080291       -0.6048467
6      24   LAYING         0.2767670       -0.01768225        -0.1079145       -0.6754592
  tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X tGravityAcc-mean()-Y
1       -0.3856738       -0.4986470            0.7406850          -0.20716136
2       -0.5220400       -0.6992935            0.6992225           0.02997678
3       -0.4488161       -0.5872306            0.7099965          -0.04208581
4       -0.6271175       -0.7015960            0.7168632          -0.01578200
5       -0.3693367       -0.6347873            0.6280406          -0.03730595
6       -0.5824907       -0.6364975            0.6949813           0.07295097
  tGravityAcc-mean()-Z tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z
1           0.10841043          -0.9647101          -0.9550424          -0.9278017
2           0.03302955          -0.9673834          -0.9605729          -0.9468086
3           0.04430105          -0.9672681          -0.9535407          -0.9387279
4           0.08999017          -0.9801387          -0.9695420          -0.9594342
5           0.10723076          -0.9582019          -0.9525068          -0.9409815
6           0.06232277          -0.9753297          -0.9608982          -0.9557246
  tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z tBodyAccJerk-std()-X
1            0.07946339           0.016939967         -0.0162372728           -0.3881353
2            0.07043031           0.005311538          0.0003081124           -0.5824183
3            0.07943930           0.003879620         -0.0123485924           -0.6388895
4            0.07748092           0.012885045          0.0008485451           -0.7346445
5            0.07981813           0.002209287         -0.0045061190           -0.6270988
6            0.07847350           0.003969003         -0.0070096056           -0.7403005
  tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z tBodyGyro-mean()-X tBodyGyro-mean()-Y
1           -0.4462061           -0.6833303        -0.01509866        -0.09174339
2           -0.5713598           -0.7926219        -0.06286635        -0.05920273
3           -0.5697005           -0.7284530        -0.05624706        -0.06166138
4           -0.7329692           -0.8472578        -0.03739938        -0.06782001
5           -0.5271746           -0.7473626        -0.02424888        -0.07894484
6           -0.6859798           -0.7363742        -0.02125781        -0.07824402
  tBodyGyro-mean()-Z tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z
1         0.08522855        -0.5888932        -0.4653584        -0.4968588
2         0.09607421        -0.7278817        -0.7350628        -0.6710577
3         0.09886606        -0.7151099        -0.6457286        -0.6433373
4         0.09084029        -0.8045337        -0.7773617        -0.7456125
5         0.08562806        -0.6845863        -0.5736774        -0.5272780
6         0.08417404        -0.7761990        -0.7633655        -0.7082517
  tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z
1            -0.11199396            -0.03977940            -0.05731096
2            -0.07311344            -0.04367882            -0.05745850
3            -0.08811824            -0.04408366            -0.05827187
4            -0.09440296            -0.04416919            -0.05684826
5            -0.09498218            -0.04143561            -0.05430013
6            -0.09982942            -0.03907494            -0.05529877
  tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z tBodyAccMag-mean()
1            -0.6325058            -0.7084319            -0.6074426         -0.3574197
2            -0.7097261            -0.8112326            -0.7493519         -0.5595865
3            -0.7157730            -0.7189886            -0.7127164         -0.5398716
4            -0.8428935            -0.8840505            -0.8386147         -0.6583710
5            -0.6983541            -0.6842807            -0.6367159         -0.5172574
6            -0.7644900            -0.7927187            -0.7968165         -0.6200327
  tBodyAccMag-std() tGravityAccMag-mean() tGravityAccMag-std() tBodyAccJerkMag-mean()
1        -0.4241859            -0.3574197           -0.4241859             -0.4621106
2        -0.5743865            -0.5595865           -0.5743865             -0.6300505
3        -0.5972310            -0.5398716           -0.5972310             -0.6254669
4        -0.6896719            -0.6583710           -0.6896719             -0.7539047
5        -0.5723258            -0.5172574           -0.5723258             -0.6196988
6        -0.6508621            -0.6200327           -0.6508621             -0.7136674
  tBodyAccJerkMag-std() tBodyGyroMag-mean() tBodyGyroMag-std() tBodyGyroJerkMag-mean()
1            -0.4090957          -0.3883145         -0.5226050              -0.6656910
2            -0.5663657          -0.6316681         -0.6848581              -0.7772945
3            -0.6102485          -0.5812154         -0.6363649              -0.7127450
4            -0.7452128          -0.7147357         -0.7757791              -0.8598999
5            -0.5886443          -0.5168612         -0.5800236              -0.6840485
6            -0.6893912          -0.6824472         -0.7429831              -0.7916466
  tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z
1             -0.7149134        -0.3915785        -0.3849666        -0.5545730
2             -0.7863865        -0.5789202        -0.5232871        -0.7266403
3             -0.7120562        -0.6388179        -0.4934672        -0.6297363
4             -0.8885653        -0.7142278        -0.6636597        -0.7612292
5             -0.6835037        -0.6126411        -0.4263987        -0.6650069
6             -0.7889979        -0.7076138        -0.6115090        -0.6558590
  fBodyAcc-std()-X fBodyAcc-std()-Y fBodyAcc-std()-Z fBodyAcc-meanFreq()-X
1       -0.3934113       -0.4258327       -0.5117645            -0.2105941
2       -0.5869226       -0.5530766       -0.7099832            -0.1837382
3       -0.6206020       -0.4625845       -0.5990369            -0.2220566
4       -0.6878505       -0.6328382       -0.6948741            -0.2102881
5       -0.6031489       -0.3815340       -0.6475156            -0.2281779
6       -0.6643567       -0.5946768       -0.6553605            -0.2633523
  fBodyAcc-meanFreq()-Y fBodyAcc-meanFreq()-Z fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y
1            0.08437831           0.084612416            -0.4120573            -0.4630582
2            0.04445984           0.068910987            -0.5991093            -0.5912964
3           -0.03483115           0.048726027            -0.6600822            -0.6033405
4            0.01420179           0.002379457            -0.7500201            -0.7441134
5           -0.01144114           0.077961545            -0.6522642            -0.5577913
6           -0.01760792           0.081258080            -0.7522454            -0.7036416
  fBodyAccJerk-mean()-Z fBodyAccJerk-std()-X fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z
1            -0.6456846           -0.4186270           -0.4666879           -0.7207366
2            -0.7754266           -0.6029601           -0.5791681           -0.8085830
3            -0.7108317           -0.6496062           -0.5621299           -0.7448235
4            -0.8330321           -0.7425179           -0.7391978           -0.8601690
5            -0.7328356           -0.6347101           -0.5259076           -0.7605091
6            -0.7196557           -0.7513782           -0.6882805           -0.7516287
  fBodyAccJerk-meanFreq()-X fBodyAccJerk-meanFreq()-Y fBodyAccJerk-meanFreq()-Z
1               -0.10230242                -0.2068312               -0.04608936
2               -0.04661986                -0.2046942               -0.09756402
3               -0.02419618                -0.2383285               -0.12060549
4               -0.06913879                -0.2118002               -0.12323590
5               -0.09465652                -0.2958514               -0.17377210
6               -0.05704235                -0.2311316               -0.13977119
  fBodyGyro-mean()-X fBodyGyro-mean()-Y fBodyGyro-mean()-Z fBodyGyro-std()-X
1         -0.5236012         -0.5452232         -0.4584138        -0.6120219
2         -0.6612468         -0.7447981         -0.6573699        -0.7503939
3         -0.6586424         -0.6471528         -0.6204712        -0.7346580
4         -0.7877576         -0.8163859         -0.7559268        -0.8121752
5         -0.6264454         -0.5910397         -0.5184445        -0.7044818
6         -0.7226074         -0.7537105         -0.7094886        -0.7940635
  fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyGyro-meanFreq()-X fBodyGyro-meanFreq()-Y
1        -0.4298158        -0.5567868            -0.10060855            -0.16664960
2        -0.7334567        -0.7082332            -0.08434983            -0.10730987
3        -0.6506236        -0.6857745            -0.11264547            -0.08061302
4        -0.7596656        -0.7663817            -0.11359631            -0.24547725
5        -0.5675886        -0.5750022            -0.15297467            -0.19728108
6        -0.7719698        -0.7357499            -0.05010786            -0.09753476
  fBodyGyro-meanFreq()-Z fBodyAccMag-mean() fBodyAccMag-std() fBodyAccMag-meanFreq()
1            -0.10703723         -0.3886843        -0.5357604             0.13822060
2            -0.06484939         -0.5592837        -0.6505333             0.07559266
3            -0.00505037         -0.5899281        -0.6653449             0.08494757
4            -0.08909279         -0.6977329        -0.7339041             0.09110717
5            -0.13831697         -0.5602789        -0.6483062             0.06049262
6            -0.05564074         -0.6501219        -0.7059284             0.02363006
  fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std() fBodyBodyAccJerkMag-meanFreq()
1                 -0.3851389                -0.4473676                     0.14291154
2                 -0.5642392                -0.5716149                     0.12632361
3                 -0.6072953                -0.6170755                     0.18286125
4                 -0.7423238                -0.7501900                     0.22459655
5                 -0.5845714                -0.5973510                     0.08722347
6                 -0.6968456                -0.6824471                     0.19842201
  fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std() fBodyBodyGyroMag-meanFreq()
1              -0.5725131             -0.5735388                 -0.01023852
2              -0.7173117             -0.7194381                 -0.04553572
3              -0.6522253             -0.6919152                  0.06258918
4              -0.8162866             -0.7897777                 -0.05736967
5              -0.6069709             -0.6358163                 -0.06767129
6              -0.7541316             -0.7820763                  0.01944860
  fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std() fBodyBodyGyroJerkMag-meanFreq()
1                  -0.7108493                 -0.7413978                      0.14588335
2                  -0.7899029                 -0.7973615                      0.07058736
3                  -0.7120544                 -0.7331836                      0.15741746
4                  -0.8846630                 -0.9022068                      0.19323149
5                  -0.6926381                 -0.6946800                      0.05042914
6                  -0.7950192                 -0.7961573                      0.16173961
