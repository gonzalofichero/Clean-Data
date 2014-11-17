
#Working in the environment...
setwd("./Archivos R/getting_data")


######
# 1. Merges the training and the test sets to create one data set.
######

#Variable X: data
veo1 <- read.table("train/X_train.txt")
veo2 <- read.table("test/X_test.txt")
    X <- rbind(veo1, veo2)

#Variable Z: Subjects
veo3 <- read.table("train/subject_train.txt")
veo4 <- read.table("test/subject_test.txt")
    Z <- rbind(veo3, veo4)

#Variable Y: labels
veo5 <- read.table("train/y_train.txt")
veo6 <- read.table("test/y_test.txt")
    Y <- rbind(veo5, veo6)

# X, Y and Z are the merges of the train and test sets for all the variables.

    #Eliminating the temporal dataframes that were created.
    for (i in 1:6){
        elimino <- paste("veo",i,sep="")
        rm(list=elimino)
    }
    rm("elimino")

####
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
####

features <- read.table("features.txt")
#I look for the variables that are means and std by looking for those words
features_wanted <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
#Adding it to the data frame
X <- X[, features_wanted]
#Putting as name and separating for neating
names(X) <- features[features_wanted, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
#Lowercase to make it neat
names(X) <- tolower(names(X))


#####
# 3. Uses descriptive activity names to name the activities in the data set.
#####
#Just the same as in the previous question, but with another file (activity_labels)
activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
#Label
names(Y) <- "activity"

#####
# 4. Appropriately labels the data set with descriptive activity names.
#####
#Z is labeled, so only rests to bind together all the data.frames in 1 and exporting
names(Z) <- "subject"
cleaned <- cbind(Z, Y, X)
write.table(cleaned, "all_data_cleaned.txt", row.names=F)

#####
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
#####

uniqueSubjects = unique(Z)[,1]
qsubjects = length(unique(Z)[,1])
qactividades = length(activities[,1])
qcolum = dim(cleaned)[2]
result = cleaned[1:(qsubjects*qactividades), ]

#I'm gonna use this variable for accumulating and moving through the rows in the loop
row.n = 1
#Looping to create the data set
for (i in 1:qsubjects) {
    for (j in 1:qactividades) {
        result[row.n, 1] = uniqueSubjects[i]
        result[row.n, 2] = activities[j, 2]
        
        tmp <- cleaned[cleaned$subject==i & cleaned$activity==activities[j, 2], ]
        
        result[row.n, 3:qcolum] <- colMeans(tmp[, 3:qcolum])
        row.n = row.n+1
    }
}

#Exporting the average values to a txt
write.table(result, "data_set_with_the_averages.txt", row.name=FALSE)