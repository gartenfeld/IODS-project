# Name: David Rosson
# Date: 14.09.2023
# File description: R script for Assignment 3
# Data source: UCI Machine Learning Repository
# http://www.archive.ics.uci.edu/dataset/320/student+performance

# During the data wrangling exercises you will join together two data sets. This will provide you with a non-trivial example of joining together data from different sources for further analysis.

# You only need to write an R script, no output in your course diary is needed. Use code comments to make your code easier to read. We  of course recommend using RStudio for writing R code.

# Go to the UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page here. Then choose "Download" to download the .zip file. Unzip the file and move the two .csv files (student-mat.csv) and (student-por.csv) to the data folder in your course project folder.

# Create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on the top of the script (include a reference to the data source). Save the script as 'create_alc.R' in the ‘data’ folder of your project. Complete the rest of the steps in that script.

# Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)

# Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)

# Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)
