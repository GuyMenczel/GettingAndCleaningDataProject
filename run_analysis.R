# !!! The below line should be changed to match the local directory where UCI HAR Dataset is located !!!
setwd("C://R Work Dir/Data Cleaning Course/Project")

library(dplyr)
#-------------------------------------------------------------------
# reading the table from x_test file which includes the measurements of the test group and load it to x_test_df data frame 
# + Adding an ID column to be used for the joining of the different files

x_test_df <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE) %>%
    mutate(id = rownames(.))

# reading the table from y_test file which includes the test group activity ID and load it to y_test_df data frame + Adding an ID 
# column to be used for the joining of the different files

y_test_df <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE) %>%
    mutate(id = rownames(.))

# reading the table from subject_test file which includes the subjest ID of the test group and load it to subject_test_df 
#data frame + Adding an ID column to be used for the joining of the different files

subject_test_df <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE) %>%
    mutate(id = rownames(.))
#-------------------------------------------------------------------

# reading the table from x_train file which includes the measurements of the training group and load it to x_train_df 
# data frame + Adding an ID column to be used for the joining of the different files

x_train_df <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE) %>%
    mutate(id = rownames(.))

# reading the table from y_train file which includes the training group activity ID and load it to y_train_df data frame 
# + Adding an ID column to be used for the joining of the different files

y_train_df <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE) %>%
    mutate(id = rownames(.))

# reading the table from subject_train file which includes the subjest ID of the training group and load it to subject_train_df 
#data frame + Adding an ID column to be used for the joining of the different files

subject_train_df <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE) %>%
    mutate(id = rownames(.))

#-------------------------------------------------------------------
# Merge all 3 dataframes of the test groups (Subject, Activity, measurements) 
merged_x_y_subject_test_df <- merge(x_test_df,y_test_df,by="id") %>%
     merge(subject_test_df,by="id")

# Merge all 3 dataframes of the training groups (Subject, Activity, measurements) 
merged_x_y_subject_train_df <- merge(x_train_df,y_train_df,by="id") %>%
     merge(subject_train_df,by="id")

# list that include all the mean and std variables
MeanStdVar <- c(201,202,214,215,227,228,240,241,253,254,503,504,516,517,529,530,542,543)

# combining the test and training data together and filter only the relevant variables + renaming the variables names
merged_ALL_filtered_df <- rbind(merged_x_y_subject_train_df, merged_x_y_subject_test_df) %>% 
  rename(
    subject = V1,
    Activity = V1.y,
  ) %>%
  select(subject,Activity,num_range("V", MeanStdVar)) %>%
    rename(
    tBodyAccMagMean = V201,
    tBodyAccMagStd = V202,
    tGravityAccMagMean = V214,
    tGravityAccMagStd = V215,
    tBodyAccJerkMagMean =V227,
    tBodyAccJerkMagStd = V228,
    tBodyGyroMagMean =V240,
    tBodyGyroMagStd = V241,
    tBodyGyroJerkMagMean = V253,
    tBodyGyroJerkMagStd = V254,
    fBodyAccMagMean = V503,
    fBodyAccMagStd = V504,
    fBodyBodyAccJerkMagMean = V516,
    fBodyBodyAccJerkMagStd = V517,
    fBodyBodyGyroMagMean = V529,
    fBodyBodyGyroMagStd = V530,
    fBodyBodyGyroJerkMagMean = V542,
    fBodyBodyGyroJerkMagStd = V543
    )

# replace the activity codes with the activity description for better clarity
merged_ALL_filtered_df$Activity <- 
  recode(merged_ALL_filtered_df$Activity,'1'="WALK",'2'="WALK_UP",'3' ="WALK_DOWN",'4'="SIT",'5'="STAND",'6'="LAY", .default = "other")

# Create the second dataframe by applying the mean function on all variables broken down by Subject & activity 
mean_by_subject_Activity_df <- aggregate(merged_ALL_filtered_df[,3:20], by=list( merged_ALL_filtered_df$Activity,
    merged_ALL_filtered_df$subject), FUN=mean, na.rm=TRUE)

# write this dataframe to a file in order to load it to GitHub
write.table(mean_by_subject_Activity_df, file = "mean_by_subject_Activity_df.txt",row.name = FALSE)
