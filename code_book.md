---
title: "Code Book"
author: "gonzalofichero"
date: "Monday, November 17, 2014"
output: html_document
---

The data comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And there is an explanation of the variables in: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



The script run_analysis.R performs the following actions to clean up the data:

1) Sets the working directory, where the data is allocated and also the script

2) Merges the training and test sets to create one data set. Then it deletes all the temporary data frames.

3) Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement, using the grep function.

4) Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set: (a) walking, (b) walkingupstairs, (c) walkingdownstairs, (d) sitting, (e)standing, (f)  laying

5) The script labels the data set with names to understand what is inside. All names are converted to lower case (underscores and brackets are removed), for making it neat. Then it merges features data.frame with the activity data.frame. The result is saved as merged_clean_data.txt. Contains: in the first column subject IDs, in the second column activity names, and all the remaining columns are measurements. 
   
6) Finally a second independent tidy data set is created, containing the average of each measurement for each activity and each subject. The variables are ID's, and then the means of the variables of the data.frame explained in point 5.