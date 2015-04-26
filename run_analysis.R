####################################################################
# 1. Merges the training and the test sets to create one data set. #
####################################################################

        ## read in training set for X
        X_trainSet<-read.table("train/X_train.txt")

        ## read in test set for X
        X_testSet<-read.table("test/X_test.txt")

        ## combin the two sets for X
        X_combinedSets<-rbind(X_trainSet, X_testSet)

        ## repeat the same for Y
        Y_trainSet<-read.table("train/Y_train.txt")
        Y_testSet<-read.table("test/Y_test.txt")
        Y_combinedSets<-rbind(Y_trainSet, Y_testSet)

        #### repeat the same for subject
        subject_trainSet<-read.table("train/subject_train.txt")
        subject_testSet<-read.table("test/subject_test.txt")
        subject_combinedSets<-rbind(subject_trainSet, subject_testSet)

#############################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.#
#############################################################################################

        ## read in the table of features
        features<-read.table("features.txt")
        
        ## select the texts with -mean() or std() and create an index of that
        goodFeatures<-grep("-mean\\(\\)|-std\\(\\)",features[, 2])
        
        ## subset with the index of good features
        goodX<-X_combinedSets[,goodFeatures]
        
        ## update the names of the columns
        names(goodX)<-features[goodFeatures, 2]
        
        ## getting rid of () in names
        names(goodX)<-gsub("\\(|\\)", "", names(goodX))

        ## changing names to lowercase
        names(goodX)<-tolower(names(goodX))
  
#############################################################################
# 3. Uses descriptive activity names to name the activities in the data set #
#############################################################################

        ## read in the table of activity
        activities <- read.table("activity_labels.txt")

        ## coerce activities into characters
        activities[,2] <-as.character(activities[,2])

        ## changing acitivities into lowercase
        activities[,2] <-tolower(activities[,2])

        ## get rid of _
        activities[,2]<-gsub("_", "", activities[,2])

        ## subset Y with activities names like a lookup table
        Y_combinedSets[,1] = activities[Y_combinedSets[,1], 2]
        names(Y_combinedSets) <- "activity"

#########################################################################
# 4. Appropriately labels the data set with descriptive variable names. #
#########################################################################

        ## change the column name to subject
        names(subject_combinedSets)<-"subject"

        ## combined all 3 parts
        data<-cbind(goodX, Y_combinedSets, subject_combinedSets)
        
####################################################################################################################
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.#
####################################################################################################################

        ## load library plyr
        library(plyr)
        
        ## calculate the average by subject and by activity
        data2<-ddply(data, . (subject, activity), function(x) colMeans(x[, 1:66]))
        
        ## write the data to a text file, comma separated
        write.table(data2, "data_means.txt",row.name=FALSE)
