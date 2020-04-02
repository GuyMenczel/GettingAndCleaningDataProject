This is the CodeBook to describe the submitted project for the "Getting and Cleaning data" course of Coursera (part of the Data Science learning topic).

The project is to clean and create a tidy data set for the "Human Activity Recognition Using Smartphones Dataset" which is loaded from the internet.

I created one R script called run_analysis.R that does the following.

1) Load the different parts of the dataset which reside in different files. the dataframe created during this step are:
A) x_test_df - which includes the measurements of the test group and was loaded from X_test.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.

B) y_test_df - which includes the test group activity ID  and was loaded from y_test.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.

C) subject_test_df - which includes the test group subject ID  and was loaded from subject_test.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.


D) x_train_df - which includes the measurements of the train group and was loaded from X_train.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.

E) y_train_df - which includes the train group activity ID  and was loaded from y_train.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.

F) subject_train_df - which includes the train group subject ID  and was loaded from subject_train.txt file. During the data load, I added also a sequence ID as a new variables to be used for the merge activity with the other parts.

2) Merge all 3 dataframes of the test group (Subject, Activity, measurements) --> merged_x_y_subject_test_df dataframe (2947 obs. of 564 variables)

3) Merge all 3 dataframes of the train group (Subject, Activity, measurements) --> merged_x_y_subject_train_df dataframe (7352 obs. of 564 variables)

4) create a list that include all the mean and std variables --> MeanStdVar (18 variables)

5) merge both the Train & Test dataframe together but Extracts only the measurements on the mean and standard deviation for each measurement  --> merged_ALL_Filtered_df (10299 obs. of 20 variables, 18 mean/std measurements + subject + activity)   

6) replace the activity codes with the activity description for better clarity

7) Create the second, independent tidy data set with the average of each variable for each activity and each subjectby  --> mean_by_subject_Activity_df dataframe

8) write this dataframe to a file in order to load it to GitHub
