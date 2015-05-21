---
title: "Codebook: Get and Clean Data Tidy Project"
author: "Y2Kaufman"
date: "Tuesday, May 19, 2015"
output: html_document
---
##CodeBook for Tidy Project - Samsung Fitness Experiment##

###Overview###
An experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities:
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. Features are normalized and bounded within [-1,1].

The script was developed using R v3.1.3 running on Windows 8.1 Lenovo laptop using RStudio Version 0.98.1103

###Input Data###

The raw input data for this project was gathered in an experiment of people exercising while wearing Samsung Galaxy S smartphones. Accelerometer and gyroscope data was collected from a variety of signals.  The input data will be downloaded and installed by the run_analysis.R script if needed, but can be reviewed at the links below:

Raw data files: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

CodeBook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data included both the raw sampled data (folder ../Inertial Signals) and Features. This project uses the features data, not the Inertial Signals.

There are several types of input files:

x: rows of feature signal measurements

y: activity labels corresponding to each row of X. 

subject: a number identifying the person on which each row of X was measured. The order of this file is in sync with the x and y files. This is important!  

feature: To determine which features correspond to which measurements, match the list of features in the file:
features.txt 
The order of this file is in sync with the x and y files. This is important!

activity: Activity labels ids are converted to descriptive names in file:
activity_labels.txt

###Input Files###

The Y, S and X data are loaded from each of the training and test dataset.
All of these files are fixed format text files.

###Data Manipuations###

The Features are processed first to pull out the std and mean columns using the grep command.  The features file is read, and the Mean and Standard Deviation variables are identified, by looking for fields ending 
in -std() or -mean().  This choice was made after carefully reviewing the contents of the feature dataset. The spec was a bit ambiguous about the 
definition of "mean" and "std", so it was safer to err on the side of selecting a few extra elements. The phrase "measurements on the mean and standard deviation for each measurement" allowed for the exclusion of fields with MEAN or STD embedded in the name, not as a suffix (e.g fBodyAccMag-**mean**Freq()).

The Training X&Y data is combined. Subject is merged in.
The Test X&Y data is combined. Subject is merged in.
The Train and Test data is combined into a single data.table

The activity descriptions are joined to the activity label data (y) and joined to the combined Train.Test data.table.

###Output Files###
The Activity ID is removed as it is no longer needed.  Column names are cleaned up.  The final data.table is called **tidy.Train.Test.Output**.
This result is output as a text file "tidy_Train_Test_Output.txt".

The data is further sub-setted to only include the activity, subject, and then the mean() function is applied. The data.table is called **tidy.Summary**

This tidy dataset is output as a text file "tidy_summary.txt".

###Data Dictionary###

1. Activity - Character - describes the exercise performed by the subject
	- WALKING
	- WALKING_UPSTAIRS
	- WALKING_DOWNSTAIRS
	- SITTING
	- STANDING
	- LAYING
      
2. Subject_ID - sequence number values 1-30 identifying the subject (person) who performed the exercise.

3. Time_Body_Acc_std_X : Freq_Body_Body_Gyro_Jerk_Mag_mean_Freq
This is an array of 79 variables collected from Samsung phones using embedded accelerometer and gyroscopes. All the measurements are similar  in nature  They describe the X, Y and Z axis of a variety of features.  For example, the acceleration signal is from the smartphone accelerometer X axis in standard gravity units 'g'.  The same description applies for the Y and Z axis.  Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file, so every row shows all 79 measurements. 


The complete list of measurement variables in the dataset is:

1.  Time_Body_Acc_std_X
2.  Time_Body_Acc_std_Y
3.  Time_Body_Acc_std_Z
4.  Time_Gravity_Acc_std_X
5.  Time_Gravity_Acc_std_Y
6.  Time_Gravity_Acc_std_Z
7.  Time_Body_AccJerk_std_X
8.  Time_Body_AccJerk_std_Y
9.  Time_Body_AccJerk_std_Z
10. Time_Body_Gyro_std_X
11. Time_Body_Gyro_std_Y
12. Time_Body_Gyro_std_Z
13. Time_Body_GyroJerk_std_X
14. Time_Body_GyroJerk_std_Y
15. Time_Body_GyroJerk_std_Z
16. Time_Body_AccMag_std
17. Time_Gravity_AccMag_std
18. Time_Body_AccJerkMag_std
19. Time_Body_GyroMag_std
20. Time_Body_GyroJerkMag_std
21. Freq_Body_Acc_std_X
22. Freq_Body_Acc_std_Y
23. Freq_Body_Acc_std_Z
24. Freq_Body_AccJerk_std_X
25. Freq_Body_AccJerk_std_Y
26. Freq_Body_AccJerk_std_Z
27. Freq_Body_Gyro_std_X
28. Freq_Body_Gyro_std_Y
29. Freq_Body_Gyro_std_Z
30. Freq_Body_Acc_Mag_std
31. Freq_Body_Body_Acc_Jerk_Mag_std
32. Freq_Body_Body_Gyro_Mag_std
33. Freq_Body_Body_Gyro_Jerk_Mag_std
34. Time_Body_Acc_mean_X
35. Time_Body_Acc_mean_Y
36. Time_Body_Acc_mean_Z
37. Time_Gravity_Acc_mean_X
38. Time_Gravity_Acc_mean_Y
39. Time_Gravity_Acc_mean_Z
40. Time_Body_Acc_Jerk_mean_X
41. Time_Body_Acc_Jerk_mean_Y
42. Time_Body_Acc_Jerk_mean_Z
43. Time_Body_Gyro_mean_X
44. Time_Body_Gyro_mean_Y
45. Time_Body_Gyro_mean_Z
46. Time_Body_Gyro_Jerk_mean_X
47. Time_Body_Gyro_Jerk_mean_Y
48. Time_Body_Gyro_Jerk_mean_Z
49. Time_Body_Acc_Mag_mean
50. Time_Gravity_Acc_Mag_mean
51. Time_Body_Acc_Jerk_Mag_mean
52. Time_Body_Gyro_Mag_mean
53. Time_Body_Gyro_Jerk_Mag_mean
54. Freq_Body_Acc_mean_X
55. Freq_Body_Acc_mean_Y
56. Freq_Body_Acc_mean_Z
57. Freq_Body_Acc_meanFreq_X
58. Freq_Body_Acc_meanFreq_Y
59. Freq_Body_Acc_meanFreq_Z
60. Freq_Body_Acc_Jerk_mean_X
61. Freq_Body_Acc_Jerk_mean_Y
62. Freq_Body_Acc_Jerk_mean_Z
63. Freq_Body_Acc_Jerk_meanFreq_X
64. Freq_Body_Acc_Jerk_meanFreq_Y
65. Freq_Body_Acc_Jerk_meanFreq_Z
66. Freq_Body_Gyro_mean_X
67. Freq_Body_Gyro_mean_Y
68. Freq_Body_Gyro_mean_Z
69. Freq_Body_Gyro_meanFreq_X
70. Freq_Body_Gyro_meanFreq_Y
71. Freq_Body_Gyro_meanFreq_Z
72. Freq_Body_Acc_Mag_mean
73. Freq_Body_Acc_Mag_meanFreq
74. Freq_Body_Body_Acc_Jerk_Mag_mean
75. Freq_Body_Body_Acc_Jerk_Mag_mean_Freq
76. Freq_Body_Body_Gyro_Mag_mean
77. Freq_Body_Body_Gyro_Mag_mean_Freq
78. Freq_Body_Body_Gyro_Jerk_Mag_mean
79. Freq_Body_Body_Gyro_Jerk_Mag_mean_Freq
