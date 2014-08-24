Code Book
========================================================

# Introduction
The script run_analysis.R performs essential cleaning and merging to produce a 
tidy dataset suitable for analysis. Learn more about the data by visiting: 
[UCI Machine Learning Repository][1].

## run_analysis.R
The script creates a directory called data to store all the relevant data files. Once the data is downloaded the following actions are performed:
* Merge the training and the test sets to create one data set.
* Extract mean and standard deviation measurementsfor each measurement 
* Add descriptive activity names to name the activities in the data set
* Label the data set with descriptive variable names
* Create tidy data set with the average of each variable for each activity/subjects

## Variable Descriptions
Variables for storing data from /data/UCI HAR DATASET/train:
* train.x: dataframe to read training set
* train.y: dataframe to read training labels
* train.sub: dataframe to read subject ID

Variables for storing data from /data/UCI HAR DATASET/test:
* test.x: dataframe to read test set
* test.y: dataframe to read etst labels
* test.sub: dataframe to subject ID

Variables for data processing: 
* x.merge: merged train and test sets
* y.merge: merged train and test labels
* sub.merge: merged ID's
* extract: stores relevant data for mean/std

Tidy dataset:
* tidy.data: dataframe containg finished tidy dataset to be written to tidy_data.txt

## Finished Data:
The tidy dataset is saved to the data directory as tidy_data.txt.



[1]:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones