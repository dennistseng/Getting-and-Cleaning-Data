#I originally was going to download the file and unzip, but cannot for the life of me get unz() to work
#This assumes the file downloaded is extracted in the wd

library(dplyr)
library(utils)

#Load tables
train_set <- read.table("train/X_train.txt")
train_labels <- read.table("train/Y_train.txt")
train_subject <- read.table("train/subject_train.txt")

test_set <- read.table("test/X_test.txt")
test_labels <- read.table("test/Y_test.txt")
test_subject <- read.table("test/subject_test.txt")

features <- read.table("features.txt", stringsAsFactors = F)
activity <- read.table("activity_labels.txt")

# Assignment Requirement
# 1. Merges the training and the test sets to create one data set.

#Combine tables to one dataset

combined_set <- rbind(train_set, test_set)
combined_labels <- rbind(train_labels, test_labels)
combined_subject <- rbind(train_subject, test_subject)

combined_dataset <- cbind(combined_set, combined_labels, combined_subject)
colnames(combined_dataset) <- c(features$V2, "Activity", "Subject")

remove_duplicates <- combined_dataset[, !duplicated(colnames(combined_dataset))] 

# Assignment Requirement
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Uses dplyr
main_dataset <- select(remove_duplicates, Subject, Activity, contains("mean"), contains("std"))

# Assignment Requirement
# 3. Uses descriptive activity names to name the activities in the data set

activity[, 2] <- tolower(activity[, 2])
main_dataset$Activity[main_dataset$Activity==1] <- activity[1,2]
main_dataset$Activity[main_dataset$Activity==2] <- activity[2,2]
main_dataset$Activity[main_dataset$Activity==3] <- activity[3,2]
main_dataset$Activity[main_dataset$Activity==4] <- activity[4,2]
main_dataset$Activity[main_dataset$Activity==5] <- activity[5,2]
main_dataset$Activity[main_dataset$Activity==6] <- activity[6,2]

# Categorical variables
main_dataset$Activity <- as.factor(main_dataset$Activity)

# Assignment Requirement
# 4. Appropriately labels the data set with descriptive variable names.

names(main_dataset) <- gsub("\\(\\)", "", names(main_dataset))
names(main_dataset) <- gsub("^t", "Time", names(main_dataset))
names(main_dataset) <- gsub("^f", "FrequencyDomainSignal", names(main_dataset))
names(main_dataset) <- gsub("^angle\\(t", "AngleBetweenTime", names(main_dataset))
names(main_dataset) <- gsub("^angle\\(f", "AngleBetweenFrequency", names(main_dataset))
names(main_dataset) <- gsub("^angle\\(", "AngleBetween", names(main_dataset))
names(main_dataset) <- gsub(")", "", names(main_dataset))
names(main_dataset) <- gsub(",", "And", names(main_dataset))
names(main_dataset) <- gsub("Acc", "Accelerometer", names(main_dataset))
names(main_dataset) <- gsub("Gyr", "Gyroscope", names(main_dataset))
names(main_dataset) <- gsub("Mag", "Magnitude", names(main_dataset))
names(main_dataset) <- gsub("std", "StandardDeviation", names(main_dataset))
names(main_dataset) <- gsub("mean", "Mean", names(main_dataset))

write.table(main_dataset, "merged_combined_dataset.txt")

# Assignment Requirement
# 5. From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity and each subject.

mean_dataset <- main_dataset %>% group_by(Subject, Activity) %>% summarise_each(funs(mean)) 

write.table(mean_dataset, "data_mean_summary.txt", row.name = FALSE)