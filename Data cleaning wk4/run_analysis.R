# Merges the training and the test sets to create one data set. DONE. 
# Extracts only the measurements on the mean and standard deviation for each measurement. DONE
# Uses descriptive activity names to name the activities in the data set. DONE
# Appropriately labels the data set with descriptive variable names. DONE
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

library(dplyr)
library(tidyr)

# Read the column names for the entire table
column_names <- as.character(read.table("UCI HAR Dataset/features.txt")$V2) 

# Read the train and test tables and combine them
data_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = column_names)
data_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = column_names)
data_combined <- bind_rows(data_train, data_test)

# Read the activity list and add a new column which describes the activity
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_train <- left_join(activity_train,activity_labels,by=c("V1"="V1"))
activity_test <- left_join(activity_test,activity_labels,by=c("V1"="V1"))
activity_combined <- bind_rows(activity_train, activity_test)
colnames(activity_combined) <- c("activity_label", "activity_name")

# Read the subject list
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_combined <- bind_rows(subject_train, subject_test)
colnames(subject_combined) <- c("subject_label")

# Extract columns which have ".mean" and ".std" in its name. Because "-" is subed by "." when importing
data_subset <- bind_cols(select(data_combined,contains(".mean")),select(data_combined,contains(".std")))

# Add the activity name cols to the subset data
data_subset <- bind_cols(activity_combined,subject_combined,data_subset)

# average of each variable for each activity and each subject.
data_summarised <- data_subset %>% group_by(activity_name,subject_label) %>% summarise_all(mean)

write.table(data_summarised,file = "summary.txt", row.name=FALSE)