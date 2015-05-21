---
title: "READ.ME Get and Clean Data: Tidy Data Project"
author: "Y2Kaufman"
date: "Sunday, May 17, 2015"
output: html_document
---
#README Tidy Data Project#
##Samsung Fitness Experiment##


##Introduction##
This document describes the steps to create the two outputs dataframes of the Samsung fitness experiment data.  Files containing Training and Test data are combined together, using reference files containing labels for the Activities. 

The script *run_analysis.R* is self contained.  It can be run start-to-finish to produce the output tidy dataset.  

The experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


##Package Set Up##
Four packages are required: plyr, dplyr, data.tables, tidyr.  
At the top of the script are the install.packages (if needed) and library commands to load them.  These steps can be skipped if the packages are already loaded.

##Input Data##
The input file should be named "project_data.zip". If the input data file is not in your working directory, it will be downloaded.  If the file has not been uncompressed, its files will be unzipped and placed in the "\UCI HAR Dataset\" subdirectory under your current working directory.  This part of the script can be skipped if you know the data already exists in your directory.

##Main Processing##
1. Feature processing - The features file is read, and the Mean and Standard Deviation variables are identified, by looking for fields ending 
in -std() or -mean().  This choice was made after carefully reviewing the contents of the feature dataset. The spec was a bit ambiguous about the 
definition of "mean" and "std", so it was safer to err on the side of selecting a few extra elements. The phrase "measurements on the mean and standard deviation for each measurement" allowed the exclusion of fields with MEAN or STD embedded in the name, not as a suffix (e.g fBodyAccMag-*mean*Freq()).

2. X-Train processing - First read in 5 records to determine the classes of the fields.  This is a performance technique, and is a good practice whenever reading a large dataset.  Next, read the X-Train file.  This contains the raw data reads from the subjects.

3. Y-Train processing - Read the Y-Train file.  This contains the Activity data.  It is in the same order as X-Train.  This is important. It is the only way to sync the files.

4. Subject-train processing - Read the subject-train file. This contains the Subject-ID.  It is also n the same order as X-Train.  This is important. It is the only way to sync the files. Combine the X, Y and subject TRAIN data.  

5. Repeat steps 2-4 for the TEST files.  

6. Combine TRAIN and TEST data.

7. Clean up the column names, replacing t prefix for "Time", f for "Freq"
changing "-" for "_"  to facilitate database processing, removing imbedded () and remove the Activity-ID

##Output Files##
1. Create a final output Tidy dataset of the data,  "tidy_Train_Test_Output.txt".

2. Group and summarize the mean of the dataset into a 180x81 table
 "tidy_summary.txt" using dplyr functions.

