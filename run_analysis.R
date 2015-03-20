# pre-process: download and unzip file
if (!file.exists("Course3Prj")){
  dir.create("Course3Prj")
}

if (!file.exists("./Course3Prj/UCI_HAR_Dataset.zip")){
  print("File not there, proceed to download")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./Course3Prj/UCI_HAR_Dataset.zip", mode="wb")
}

if (!file.exists("./Course3Prj/UCI HAR Dataset")){
  print("Extracted folder not found, proceed with unzip")
  unzip("./Course3Prj/UCI_HAR_Dataset.zip", exdir="./Course3Prj")
}

print("Data preparation")
title <- read.table("./Course3Prj/UCI HAR Dataset/features.txt", sep="", header=FALSE)
activity_label <- read.table("./Course3Prj/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE, col.names = c("activityID","activityName"))

training_set <- read.table("./Course3Prj/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training_set_y <- read.table("./Course3Prj/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE, col.names = "activityID")
training_set_subject <- read.table("./Course3Prj/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE, col.names = "subjectID")

test_set <- read.table("./Course3Prj/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_set_y <- read.table("./Course3Prj/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE, col.names = "activityID")
test_set_subject <- read.table("./Course3Prj/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE, col.names = "subjectID")

print("Proceed to #1 & #3")
# 1. Merges the training and the test sets to create one data set
# 3. Uses descriptive activity names to name the activities in the data set
combined_set <- rbind(test_set,training_set)
names(combined_set) <- title$V2
combined_set_y <- rbind(test_set_y, training_set_y)
combined_set_y[,1] <- activity_label$activityName[combined_set_y[,1]]
combined_set <- cbind(combined_set,combined_set_y,rbind(test_set_subject, training_set_subject))

print("Proceed to #2")
# 2. Extracts only the measurements on the mean and standard deviation for each measurement, 
# take in my additional two variables too
selected_title <- grepl("mean|std|activityID|subjectID",title$V2, ignore.case = TRUE)
combined_set_selected <- combined_set[,selected_title]

print("Proceed to #4")
# 4. Appropriately labels the data set with descriptive variable names
names(combined_set_selected) <-gsub("\\(","",names(combined_set_selected))
names(combined_set_selected) <-gsub("\\)","",names(combined_set_selected))
names(combined_set_selected) <- make.names(names(combined_set_selected))
names(combined_set_selected) <-gsub("^t","Time",names(combined_set_selected))
names(combined_set_selected) <-gsub("^f","Frequency",names(combined_set_selected))
names(combined_set_selected) <-gsub("Acc","Acceleration",names(combined_set_selected))
names(combined_set_selected) <-gsub("Mag","Magnitude",names(combined_set_selected))
names(combined_set_selected) <-gsub("mean","Mean",names(combined_set_selected))
names(combined_set_selected) <-gsub("Freq","Frequency",names(combined_set_selected))
names(combined_set_selected) <-gsub("std","StandardDeviation",names(combined_set_selected))
names(combined_set_selected) <-gsub("Mag","Magnitude",names(combined_set_selected))

print("Proceed to #5")
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject
combined_set_tidy <- aggregate(. ~subjectID + activityID  ,combined_set_selected, mean)
combined_set_tidy <- combined_set_tidy[order(combined_set_tidy$subjectID,combined_set_tidy$activityID),]
write.table(combined_set_tidy, file = "./Course3Prj/tidyData.txt", row.names=FALSE)

print("Process completed")