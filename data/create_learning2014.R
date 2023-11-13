# Read the full learning2014 data into a data frame
learning_2014_data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the structure of the data
str(learning_2014_data)
# Structure output:
# 'data.frame':	183 obs. of  60 variables:

# Look at the dimensions of the data
dim(learning_2014_data)
# Dimensions output:
# [1] 183  60

# 183 rows, 60 columns -- that's a large number of variables
# Gauging from the metadata info sheet, many of these columns
# used to be individual questionnaire questions

# `Attitude` is the sum of scores from 10 questions
learning_2014_data$Attitude

# The instructions suggest you could "scale" the sum score 
# back to an "original" scale by dividing it by the number of questions
# Store the reverse-split values in a new column with lowercase name
learning_2014_data$attitude <- learning_2014_data$Attitude / 10

# Create combo variables
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surf_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
stra_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Below the "scaling back" is done within the same step by taking the mean

# select the columns related to deep learning 
deep_columns <- select(learning_2014_data, one_of(deep_questions))
# and create column 'deep' by averaging
learning_2014_data$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surf_columns <- select(learning_2014_data, one_of(surf_questions))
# and create column 'surf' by averaging
learning_2014_data$surf <- rowMeans(surf_columns)

# select the columns related to strategic learning 
stra_columns <- select(learning_2014_data, one_of(stra_questions))
# and create column 'stra' by averaging
learning_2014_data$stra <- rowMeans(stra_columns)

# Keep the columns named in the instructions
kept_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning_2014 <- select(learning_2014_data, one_of(kept_columns))

dim(learning_2014)
# [1] 183   7

str(learning_2014)
# 'data.frame':	183 obs. of  7 variables:
# $ gender  : chr  "F" "M" "F" "M" ...
# $ Age     : int  53 55 49 53 49 38 50 37 37 42 ...
# $ attitude: num  3.7 3.1 2.5 3.5 3.7 3.8 3.5 2.9 3.8 2.1 ...
# $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
# $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
# $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
# $ Points  : int  25 12 24 10 22 21 21 31 24 26 ...

colnames(learning_2014)[2] <- "age"
colnames(learning_2014)[7] <- "points"
# Good to know statisticians count from 1

# Drop rows where points equals 0
filtered <- filter(learning_2014, points != 0)

dim(filtered)
# [1] 166   7
# which matches the prophecy:
# "The data should then have 166 observations and 7 variables"

# Write the data to a CSV
library(readr)
write_csv(filtered, 'data/learning_2014.csv')

# Test loading data from CSV file
wrangled <- read_csv('data/learning_2014.csv')

# Check data shape
str(wrangled)
# spc_tbl_ [166 × 7] 

head(wrangled)
# gender   age attitude  deep  stra  surf points
# <chr>  <dbl>    <dbl> <dbl> <dbl> <dbl>  <dbl>
# 1 F         53      3.7  3.58  3.38  2.58     25
# 2 M         55      3.1  2.92  2.75  3.17     12
# 3 F         49      2.5  3.5   3.62  2.25     24

# Looks legit!
