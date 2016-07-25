## Getting and Cleaning Data - Week 4 Assignment

This readme will discuss the run_analysis.R script and how to use it to process data from 
the following link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## R Environment and Operating System

The following environment was used to write and run the script:

```
Windows 10
RStudio 0.99.887
R x64 3.3.1
```

## Instructions

1. First, download and unzip the following dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. Place unzipped file contents in its existing directory structure into the working directory.
3. Ensure that run_analysis.R and the files are in the same working directory.
4. Please ensure that the packages "utils" and "dplyr" are installed before running the script.
5. Run the script in either R by pressing the Source button or typing source("run_analysis.R") in the command line.
6. Upon running the file, two files will be outputed. "merged_combined_dataset.txt" contains the full merged dataset containing means and standard deviations for each measurement, while "data_mean_summary.txt" contains a tidy data set with the average of each variable for each activity and each subject.