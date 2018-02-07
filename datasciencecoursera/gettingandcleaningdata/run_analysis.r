# Dataset Folder
dir <- "UCI HAR Dataset"

library("dplyr")
library("reshape2")

load_file <- function(filename, ...) {
  file.path(..., filename) %>%
  read.table(header = FALSE)
}

# Describe test / train labels
set_labels <- function(df, activity_labels) {
  names(df) <- "Activity"
  df$Activity <- factor(df$Activity, levels = activity_labels$V1, labels = activity_labels$V2)
  df
}

# Associate column names with features and clean up the column names
associate_features <- function(df, features) {
  col_names <- gsub("-", "_", features$V2)
  col_names <- gsub("[^a-zA-Z\\d_]", "", col_names)
  names(df) <- make.names(names = col_names, unique = TRUE, allow_ = TRUE)
  df
}

##Adjusts column name in the data set identifying test participants
set_df_name <- function(df) {
  names(df) <- "Subject"
  df
}

# Download and extract a zip file with datasets
if (!file.exists(dir)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip", method = "curl")
  unzip("data.zip")
}

## Load features as human-readable column names
features <- load_file("features.txt", dir)

## Load activity labels
activity_labels <- load_file("activity_labels.txt", dir)

# Training data
train_set <- load_file("X_train.txt", dir, "train") %>% associate_features(features)
train_lbl <- load_file("y_train.txt", dir, "train") %>% set_labels(activity_labels)
train_sub <- load_file("subject_train.txt", dir, "train") %>% set_df_name

# Test data
test_set <- load_file("X_test.txt", dir, "test") %>% associate_features(features)
test_lbl <- load_file("y_test.txt", dir, "test") %>% set_labels(activity_labels)
test_sub <- load_file("subject_test.txt", dir, "test") %>% set_df_name

## Merge the training and the test sets
dataset <- rbind(
    cbind(train_set, train_lbl, train_sub),
    cbind(test_set, test_lbl, test_sub)
  ) %>%
  select(
    matches("mean|std"),
    one_of("Subject", "Activity")
  )

## Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- melt(
    dataset,
    id = c("Subject", "Activity"),
    measure.vars = setdiff(colnames(dataset), c("Subject", "Activity"))
  ) %>%
  dcast(Subject + Activity ~ variable, mean)

## Save the result
write.table(tidy_data, file = "data.txt", sep = ",", row.names = FALSE)
