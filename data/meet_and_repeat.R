# Name: David Rosson
# Date: 06.12.2023
# File description: R script for Assignment 6
# Data source: MABS4IODS (Part VI) by Vehkalahti and Everitt (2019)

### Step 1 ###
# Load the wide form data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep  =" ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# "Write the wrangled data sets to files in your IODS-project `data` folder"
library(readr)
write_csv(BPRS, "data/BPRS_wide.csv")
write_csv(RATS, "data/RATS_wide.csv")

# Take a look at the data sets: check their variable names
names(BPRS)
#  [1] "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"     "week7"     "week8" 

names(RATS)
# [1] "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64" 

# View the data contents and structures
glimpse(BPRS)
str(BPRS)

glimpse(RATS)
str(RATS)

# Create some brief summaries of the variables

#### BPRS ####
# treatment: treatment group ID
# subject: participant ID
# week0-week8: participant's score on "brief psychiatric rating scale"

#### RATS ####
# ID: rat ID
# Group: diet group ID
# WD1-WD64: rat's weight in grams on that day


### Step 2 ###
# "Convert the categorical variables of both data sets to factors"
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


### Step 3 ###

# "Convert the data sets to long form"

BPRS_long <- pivot_longer(
  BPRS, 
  cols=-c(treatment,subject),
  names_to = "weeks",
  values_to = "bprs"
) 

RATS_long <- pivot_longer(
  RATS, 
  cols = -c(ID, Group), 
  names_to = "WD",
  values_to = "Weight"
) 

# "Add a week variable to BPRS"
BPRS_long <- BPRS_long %>% 
  mutate(week = as.integer(substr(weeks, 5, 5))) %>% 
  arrange(week)

# "Add a Time variable to RATS"
RATS_long <- RATS_long %>%
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)

### Step 4 ###

# Remove redundant columns
library(dplyr)
BPRS_long <- BPRS_long %>% select(-weeks)
RATS_long <- RATS_long %>% select(-WD)

# "Check the variable names"
names(BPRS_long)
names(RATS_long)

# "View the data contents and structures"
glimpse(BPRS_long)
glimpse(RATS_long)
str(BPRS_long)
str(RATS_long)

# "Create some brief summaries of the variables"

#### BPRS ####
# treatment: treatment group ID
# subject: participant ID
# bprs: participant's score on "brief psychiatric rating scale" for that week
# week: week number when score is recorded

#### RATS ####
# ID: rat ID
# Group: diet group ID
# Weight: rat's weight in grams on that day
# Time: the day number when weight is recorded

# Understanding: the data tables are pivoted so that measurements recorded 
# in multiple columns at different times (longitudinally) are "melted" to 
# a single column when the timing of the measurement recorded as its key 
# in another column.

write_csv(BPRS_long, "data/BPRS_long.csv")
write_csv(RATS_long, "data/RATS_long.csv")
