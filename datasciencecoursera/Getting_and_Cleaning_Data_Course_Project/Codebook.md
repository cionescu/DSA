# Code Book
This code book contains all the variables and summaries calculated, along with units, and any other relevant information needed to clean up the dataset.
The result is [data.txt](https://github.com/cionescu/DSA/blob/master/datasciencecoursera/Getting_and_Cleaning_Data_Course_Project/data.txt)

## Dataset
* Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original Codebook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Partitioning
The data was partitioned into test data (30% of the entries) and training data (70% of the entries). These were merged together to get the full dataset (stored in the `dataset` local variable).

## Transformations

* Merged the training and test data
* Only the mean and std columns were taken into account (`select(matches("mean|std"), one_of("Subject", "Activity"))`)
* Improved activity names and labels to increase readability
* Create a separate (_tidy_) dataset to store the results of the processing.

The column names have been filtered to be more in line with the R standards. Non characters were removed (excepting underscore) and all dashes were converted to underscores. Eg:

* 'tBodyGyroJerk-mean()-X' has been changed to 'tBodyGyroJerk_mean_X'
* 'tBodyGyroJerk-std()-Z'  has been changed to 'tBodyGyroJerk_std_Z'

The transformations are achieved by the script called [run_analysis.R](https://github.com/cionescu/DSA/blob/master/datasciencecoursera/Getting_and_Cleaning_Data_Course_Project/run_analysis.r), which:

1. Ensures that all non-standard R packages (dplyr, reshape2) are installed
2. Defines a number of helper functions to promote code reuse
3. Downloads the original dataset and verifies its content
4. Loads activity and label names datasets
5. Loads training and test datasets and enhances column names with appropriate labels
6. Merges the testing and the test datasets using dplyr's support for method chaining (pipe operator)
7. Creates an independent tidy dataset based on mean and standard deviations
8. Stores the results in [data.txt](https://github.com/cionescu/DSA/blob/master/datasciencecoursera/Getting_and_Cleaning_Data_Course_Project/data.txt)
