# Name: David Rosson
# Date: 14.09.2023
# File description: R script for Assignment 3
# Data source: UCI Machine Learning Repository
# http://www.archive.ics.uci.edu/dataset/320/student+performance

### Data wrangling

## Step 1

# Download data from UCI Machine Learning Repository 
# and add two CSV files to `data/`.

## Step 2

# Create this R script file.

## Step 3

# Read both student-mat.csv and student-por.csv into R (from the data folder) 
# and explore the structure and dimensions of the data.

mat <- read.table("data/student-mat.csv", sep = ";" , header = TRUE)
por <- read.table("data/student-por.csv", sep = ";" , header = TRUE)

str(mat)
str(por)

dim(mat)
dim(por)

## Step 4

# Join the two data sets using all other variables other than 
# "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers.

library(dplyr)
non_identifier_columns <- c("failures","paid","absences","G1","G2","G3")
identifier_columns <- setdiff(colnames(por), non_identifier_columns)

# Join the two datasets
# Keep only the students present in both data sets. Note: inner_join in R 
#   drops rows not present in both sets by default.
joined_data <- inner_join(mat, por, by = identifier_columns)

# Explore the structure and dimensions of the joined data.
str(joined_data)
dim(joined_data)

## Step 5

# Get rid of the duplicate records in the joined data set. 

# Note: after inner join the non-identifier columns may appear twice, one
# from each dataset. The instructions assume they repeat the same values.

# Create a new data frame with joined columns
repopulated_data <- select(joined_data, all_of(identifier_columns))

for(column_name in non_identifier_columns) {
  # Select two duplicating columns
  repeated_columns <- select(joined_data, starts_with(column_name))
  
  # Select the first column vector of those two columns
  first_of_two_as_df <- select(repeated_columns, 1)
  fisrt_column_as_array <- first_of_two_as_df[[1]]
  is_numeric_column = is.numeric(fisrt_column_as_array)

  if(is_numeric_column) {
    repopulated_data[column_name] <- round(rowMeans(repeated_columns))
  } else {
    repopulated_data[column_name] <- fisrt_column_as_array
  }
}

glimpse(repopulated_data)

## Step 6

alc <- repopulated_data

alcohol_consumption_columns = select(alc, c("Dalc", "Walc"))

# Take the average of the answers related to weekday and weekend alcohol 
# consumption to create a new column 'alc_use' to the joined data. 
alc <- mutate(alc, alc_use = rowMeans(alcohol_consumption_columns))

# Then use 'alc_use' to create a new logical column 'high_use' which is 
# TRUE for students for which 'alc_use' is greater than 2 (FALSE otherwise).
alc <- mutate(alc, high_use = alc_use > 2)

## Step 7

# Glimpse at the joined and modified data to make sure everything is in order.
# The joined data should now have 370 observations.

glimpse(alc)

# Rows: 370
# Columns: 37

# Save the joined and modified data set to the ‘data’ folder
library(readr)
write_csv(alc, "data/drunk_kids.csv")
