Steps
=====

The R script (`run_analysis.R`) performs the 5 steps required by the Coursera project to clean up the data:

* Merges the training and test sets to create one data set. This is done with the `rbind()` function

* Extracts only the measurements on the mean and standard deviation for each measurement using features from `features.txt`, selects desired columns, makes modifications to the names, and converts them to lower case

* Uses descriptive activity names to name the activities in the data set by taking information from `activity_labels.txt`, converts the names to lower case, and make modifications to them

* Appropriately labels the data set with descriptive variable names by adding the subject names 

* Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject. This is done with the `ddply()` function and an output is generated


Variables
=========

* The variables `X_trainSet`, `X_testSet`, `Y_trainSet`, `Y_testSet`, `subject_trainSet` and `subject_testSet` contain the individual tables prior to merging
* The above variables are merged into `X_combinedSet`, `Y_combinedSet` and `subject_combinedSet`
* The variable `features` contains the names used to select relevant names with means and stds in `X_combinedSets` 
* The variable `activities` contains the names of the activities used for `Y_combinedSets`
* `X_combinedSets`, `Y_combinedSets`, `subject_combinedSet` are merged into a big dataset `data` 
* The variable `data2` contains the averages that are required in step 5 of the project