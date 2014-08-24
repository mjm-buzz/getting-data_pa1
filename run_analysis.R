# run_analysis.R
# August 24, 2014
#
# This script prepares a human activity dataset for analysis by performing essential
# cleaning and merging. The data was collected from the accelerometers from 
# the Samsung Galaxy S smartphone. See full description at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(plyr)

## Getting data
# Create directory to store all data files
if (!file.exists("data")) {
        dir.create("data")
}
# Download UCI dataset and unzip
if (!file.exists("data/UCI HAR Dataset")) {
        file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zip <- "data/UCI_HAR_Dataset.zip"
        download.file(file.url, destfile=zip, method="curl")
        unzip(zip, exdir="data")
        }
message("Download complete.")


## Reading data: 
# Read data from train directory
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.sub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")        
# Read data from test directory
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.sub <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
message("Data read.")  


## Merging:
# Merge training and test data sets 
x.merge <- rbind(train.x, test.x)
y.merge <- rbind(train.y, test.y)
sub.merge <- rbind(train.sub, test.sub)
message("Data merged")      


## Extracting mean and standard deviation:
# Read features list 
features <- read.table("data/UCI HAR Dataset/features.txt")
# Find the mean and std columns
mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
# Extract mean and std to data frame
extract <- x.merge[, (mean.col | std.col)]
colnames(extract) <- features[(mean.col | std.col), 2]


## Descrptive activity names 
# Add descriptive acticity names to the dataset
colnames(y.merge) <- "activity"
y.merge$activity[y.merge$activity == 1] = "WALKING"
y.merge$activity[y.merge$activity == 2] = "WALKING_UPSTAIRS"
y.merge$activity[y.merge$activity == 3] = "WALKING_DOWNSTAIRS"
y.merge$activity[y.merge$activity == 4] = "SITTING"
y.merge$activity[y.merge$activity == 5] = "STANDING"
y.merge$activity[y.merge$activity == 6] = "LAYING"
# Subject names
colnames(sub.merge) <- c("subject")
message("Descriptive variable names added.")


## Combine the data to create one tidy dataset
bind <- cbind(extract, y.merge, sub.merge)
tidy.data <- ddply(bind, .(subject, activity), function(x) colMeans(x[,1:60]))


## Write tidy dataset to txt file
write.table(tidy.data, file="data/tidy_data.txt", row.names=FALSE)
message("Tidy dataset saved as tidy_data.txt.")