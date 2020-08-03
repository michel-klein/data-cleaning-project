library(plyr)
library(dplyr)

##Import .txt files as tibble
X_test <- as_tibble(read.table("./data/test/X_test.txt"))
Y_test <- as_tibble(read.table("./data/test/Y_test.txt"))
subject_test <- as_tibble(read.table("./data/test/subject_test.txt"))

X_train <- as_tibble(read.table("./data/train/X_train.txt"))
Y_train <- as_tibble(read.table("./data/train/Y_train.txt"))
subject_train <- as_tibble(read.table("./data/train/subject_train.txt"))

##Attribute names to the variables
features <- (read.table("./data/features.txt"))
names(X_test) <- features[,2]
names(X_train) <- features[,2]
names(Y_test) <- c("Activity")
names(Y_train) <- c("Activity")
names(subject_test) <- c("Subject")
names(subject_train) <- c("Subject")

##Merge all data
train <- bind_cols(subject_train, Y_train, X_train)
test <- bind_cols(subject_test, Y_test, X_test)
alldata <- bind_rows(train, test)

##Select only the desired columns (subject, activity; mean and standard deviation for each measurement)
selectdata <- select(alldata, Subject, Activity, grep("mean|std", names(alldata)), -(grep("meanFreq", names(alldata))))

##Apply descriptive activity names to name the activities in the data set
activity <- (read.table("./data/activity_labels.txt"))
selectdata <- mutate(selectdata, Activity = activity[match(Activity, activity[,1]),2])

##Labels the data set with descriptive variable names
listnames <- strsplit(names(selectdata), "-")
for(j in 1:length(listnames)) {
        if(listnames[[j]][1]=="tBodyAcc"){
                listnames[[j]][1] <- "BodyAccelerationSignal"
        }
        if(listnames[[j]][1]=="tGravityAcc"){
                listnames[[j]][1] <- "GravityAccelerationSignal"
        }
        if(listnames[[j]][1]=="tBodyAccJerk"){
                listnames[[j]][1] <- "BodyAccelerationSignalJerk"
        }
        if(listnames[[j]][1]=="tBodyGyro"){
                listnames[[j]][1] <- "BodyGiroscopeSignal"
        }
        if(listnames[[j]][1]=="tBodyGyroJerk"){
                listnames[[j]][1] <- "BodyGiroscopeSignalJerk"
        }
        if(listnames[[j]][1]=="tBodyAccMag"){
                listnames[[j]][1] <- "BodyAccelerationSignalMagnitude"
        }
        if(listnames[[j]][1]=="tGravityAccMag"){
                listnames[[j]][1] <- "GravityAccelerationSignalMagnitude"
        }
        if(listnames[[j]][1]=="tBodyAccJerkMag"){
                listnames[[j]][1] <- "BodyAccelerationSignalJerkMagnitude"
        }
        if(listnames[[j]][1]=="tBodyGyroMag"){
                listnames[[j]][1] <- "BodyGiroscopeSignalMagnitude"
        }
        if(listnames[[j]][1]=="tBodyGyroJerkMag"){
                listnames[[j]][1] <- "BodyGiroscopeSignalJerkMagnitude"
        }
        if(listnames[[j]][1]=="fBodyAcc"){
                listnames[[j]][1] <- "BodyAccelerationSignalFourier"
        }
        if(listnames[[j]][1]=="fBodyAccJerk"){
                listnames[[j]][1] <- "BodyAccelerationSignalJerkFourier"
        }
        if(listnames[[j]][1]=="fBodyGyro"){
                listnames[[j]][1] <- "BodyGiroscopeSignalFourier"
        }
        if(listnames[[j]][1]=="fBodyAccMag"){
                listnames[[j]][1] <- "BodyAccelerationSignalMagnitudeFourier"
        }
        if(listnames[[j]][1]=="fBodyBodyAccJerkMag"){
                listnames[[j]][1] <- "BodyAccelerationSignalJerkMagnitudeFourier"
        }
        if(listnames[[j]][1]=="fBodyBodyGyroMag"){
                listnames[[j]][1] <- "BodyGiroscopeSignalMagnitudeFourier"
        }
        if(listnames[[j]][1]=="fBodyBodyGyroJerkMag"){
                listnames[[j]][1] <- "BodyGiroscopeSignalJerkMagnitudeFourier"
        }
        
        if(is.na(listnames[[j]][2])==FALSE){
                if(listnames[[j]][2]=="mean()"){
                        listnames[[j]][2] <- "Mean"
                }
                if(listnames[[j]][2]=="std()"){
                        listnames[[j]][2] <- "Std"
                }
                if(is.na(listnames[[j]][3])==FALSE){
                        listnames[[j]] <- paste(listnames[[j]][1], listnames[[j]][2], listnames[[j]][3], sep = "")
                } else {
                        listnames[[j]] <- paste(listnames[[j]][1], listnames[[j]][2], sep = "")
                }
                        
        }
}
names(selectdata) <- listnames


##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- arrange(as_tibble(aggregate(. ~Subject + Activity, groupdata, mean)),Subject, Activity)

##Exports the tidy dataset as .txt file
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
