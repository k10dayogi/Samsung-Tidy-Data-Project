############################################################################
#    Tidy Data Project R Script
############################################################################

dateDownloaded <- date()
dateDownloaded
########################################################################
# set up - package installs and libraries if not already loaded
########################################################################
#######install.packages############
require("plyr")
require("data.table")
require("dplyr")
require("tidyr")

library(plyr)
library(dplyr)
library(data.table)

########################################################################
# set up - download & unzip input data if not in working dir
#  looking for a subdirectory called '/UCI HAR Dataset' or a file
#  called project_data.zip
########################################################################

if (!file.exists("./UCI HAR Dataset")){
      if (!file.exists("project_data.zip")){
            
            download.file(
                  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                  , "./project_data.zip")
      }
      unzip("./project_data.zip")      
}
      


#########################################################################
#                 Features processing
#########################################################################

infile <- "./UCI HAR Dataset/features.txt"
features <- read.csv(infile
                     , header = F
                     , sep = " "
                     , colClasses = "character"
                     , col.names = c("seq", "feature")) 
std.vector <- grep(pattern="-std()",x=features$feature, ignore.case=T)
mean.vector <- grep(pattern="-mean()",x=features$feature, ignore.case=T)

std.mean.vector <- c(std.vector, mean.vector) #combines all std and mean variables

#########################################################################
#                X Train processing
#########################################################################

infile <- "./UCI HAR Dataset/train/X_train.txt"

width.vector <- (rep(16,length(std.mean.vector)))
#features.labels <- select(features[std.mean.vector], feature)
features.labels <- features[std.mean.vector, 2]

# read 5 records in to determine the classes of the fields.  This is 
# a performance technique for reading big datasets

tmp <- data.table(read.fwf(infile, header = F
                           , widths = width.vector
                           , sep = ","
                           , col.names = features.labels
                           , nrows = 5)) 

classes <- sapply(tmp, class)

x.train <- data.table(read.fwf(infile
                               , header = F
                               , widths = width.vector
                               , sep = ","
                               , col.names = features.labels
                               , colClasses = classes
                               , comment.char = "")) 

#########################################################################
#                 Y Train processing
#########################################################################

infile <- "./UCI HAR Dataset/train/Y_train.txt"

width.vector <- 1
activity.labels <- "Activity_ID"

y.train <- data.table(read.fwf(infile
                               , header = F
                               , widths = width.vector
                               , sep = ","
                               , col.names = activity.labels)) 

#########################################################################
#                 Subject Train processing
#########################################################################

infile <- "./UCI HAR Dataset/train/subject_train.txt"

subject.labels <- "Subject_ID"

subject.train <- data.table(read.table(infile
                                     , header = F
                                     , sep = ","
                                     , col.names = subject.labels)) 

train.1 <- cbind(subject.train, y.train) #combine subject and activity code
train.1 <- cbind(train.1, x.train) #combine subj/act with training

#########################################################################
#             X Test processing
#########################################################################

infile <- "./UCI HAR Dataset/test/X_test.txt"

width.vector <- (rep(16,length(std.mean.vector)))

x.test <- data.table(read.fwf(infile
                              , header = F
                              , widths = width.vector
                              , sep = ","
                              , col.names = features.labels
                              , colClasses = classes
                              , comment.char = "")) 

#########################################################################
#             Y Test processing
#########################################################################

infile <- "./UCI HAR Dataset/test/Y_test.txt"

width.vector <- 1

y.test <- data.table(read.fwf(infile
                              , header = F
                              , widths = width.vector
                              , sep = ","
                              , col.names = activity.labels)) 

#########################################################################
#                 Subject Test processing
#########################################################################

infile <- "./UCI HAR Dataset/test/subject_test.txt"

subject.test <- data.table(read.table(infile
                                    , header = F
                                    , sep = ","
                                    , col.names = subject.labels)) 

test.1 <- cbind(subject.test, y.test) #combine subject and activity code
test.1 <- cbind(test.1, x.test) #combine sub/act with test

train.Test.1 <- rbind(test.1, train.1) #combine test and train data

#########################################################################
#                 Activity Label processing
#########################################################################

infile <- "./UCI HAR Dataset/activity_labels.txt"

width.vector <- 1
activity.labels <- c("Activity_ID", "Activity")

activities <- data.table(read.table(infile
                                    , header = F
                                    , sep = " "
                                    , col.names = activity.labels)) 

train.Test.Complete <- join(activities,train.Test.1, by = "Activity_ID")

############################################################################
#    clean up column names  - convert t to Time, f to Freq, and '-' to '_'
#                             removed ()
#    remove Activity_ID
############################################################################
tidy.Train.Test.Output <-  select(train.Test.Complete, -1) # remove Activity ID, not needed with the label

features.labels <- gsub("-", "_", features.labels)
features.labels <- gsub("\\()", "", features.labels)
features.labels <- gsub("^tGravity", "timeGravity", features.labels)
features.labels <- gsub("^tBody", "timeBody", features.labels)
features.labels <- gsub("^fBody", "freqBody", features.labels)

setnames(tidy.Train.Test.Output, 
         c("Activity", "Subject_ID", features.labels))


write.table(tidy.Train.Test.Output, 
           "tidy_Train_Test_Output.txt", row.name=FALSE)

View(tidy.Train.Test.Output)

#########################################################################
#    create summary mean file for step #5
#########################################################################

tidy.Summary <- (tidy.Train.Test.Output %>% 
                   group_by (Activity, Subject_ID) %>% 
                   summarise_each (funs(mean), 3:81) %>%
                   arrange(Activity, Subject_ID))

write.table(tidy.Summary, 
           "tidy_summary.txt",  row.name=FALSE)

View(tidy.Summary)

############################################################################
#    the end
############################################################################

dateCompleted <- date()
dateCompleted

