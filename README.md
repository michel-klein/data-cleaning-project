# data-cleaning-project
 The final project for the Getting and Cleaning Data Coursera course.

This repo consists in cleaning the data of human activity using smartphones, available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Firstly, the .zip file were extracted to the data folder, outside the R script. Then, the following .txt files were loaded into R objects: Subject_test, x_test, y_test, subject_train, x_train, y_train, features. The datasets were transformed into tibble objects, using the as_tibble() function, that substitutes the tbl_df() function taught in the lesson.
In the next step, all the data set were merged accordingly, using commands from the dplyr package. The variable names in the features.txt were applied to the dataset.
Then, the variables which included "std" and "mean" were selected.
Afterwards, the activities column were described accordingly, and the variable names were altered to better understanding.
At last, an independent tidy data set were created, with the average of each variable for each activity and each subject.
