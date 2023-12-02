# Name: David Rosson
# Date: 02.12.2023
# File description: R script for Assignment 5
# Data source: United Nations
# https://hdr.undp.org/data-center/human-development-index#/indicies/HDI

# Step 1: Create this file

# Step 2: Read in the “Human development” and “Gender inequality” data sets

library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Step 3: Explore the datasets: see the structure and dimensions of the data. 

str(hd)
dim(hd)

str(gii)
dim(gii)

# "Create summaries of the variables."

summary(hd)
summary(gii)

# Step 4: Look at the meta files and rename the variables with (shorter) descriptive names.

colnames(hd)[colnames(hd) == "Gross National Income (GNI) per Capita"] <- "GNI"
colnames(hd)[colnames(hd) == "Life Expectancy at Birth"] <- "Life.Exp"
colnames(hd)[colnames(hd) == "Expected Years of Education"] <- "Edu.Exp"

colnames(gii)[colnames(gii) == "Maternal Mortality Ratio"] <- "Mat.Mor"
colnames(gii)[colnames(gii) == "Adolescent Birth Rate"] <- "Ado.Birth"

colnames(gii)[colnames(gii) == "Percent Representation in Parliament"] <- "Parli.F"
colnames(gii)[colnames(gii) == "Population with Secondary Education (Female)"] <- "Edu2.F"
colnames(gii)[colnames(gii) == "Population with Secondary Education (Male)"] <- "Edu2.M"
colnames(gii)[colnames(gii) == "Labour Force Participation Rate (Female)"] <- "Labo.F"
colnames(gii)[colnames(gii) == "Labour Force Participation Rate (Male)"] <- "Labo.M"

# Step 5 Mutate the “Gender inequality” data and create two new variables. 
# The first new variable should be the ratio of female and male populations with secondary education in each country (i.e., Edu2.F / Edu2.M). 
# The second new variable should be the ratio of labor force participation of females and males in each country (i.e., Labo.F / Labo.M)

gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M

# Step 6: Join together the two data sets using the variable Country as the identifier.
# Keep only the countries in both data sets (Hint: inner join). 
# The joined data should have 195 observations and 19 variables. 
# Call the new joined data "human" and save it in your data folder.

human <- inner_join(hd, gii, by = c("Country"))
dim(human)

write_csv(human, "data/miserere.csv")

### WEEK 5 ###

# Continue from last week's script
human <- read_csv('data/miserere.csv')

#  "The joined data should have 195 observations and 19 variables"

# Step 1
# "Explore the structure and the dimensions of the 'human' data"
str(human)
dim(human)
# [1] 195  19

# "Describe the dataset briefly, assuming the reader has no previous knowledge of it"

# The dataset contains indicators related to the Human Development Index (HDI) and gender inequality in listed countries.

# A description for the columns:

# HDI Rank: The rank of the country based on its Human Development Index (HDI).
# Human Development Index (HDI): A composite index that measures the average achievements in a country in three basic dimensions of human development: health, education, and standard of living.
# Life Expectancy (Life.Exp): The average number of years a person can expect to live.
# Expected Years of Education (Edu.Exp): the average number of years of education that a child entering school can expect to receive.
# Mean Years of Education: The average number of years of education received by people aged 25 and older.
# Gross National Income (GNI): The total domestic and foreign output claimed by residents of a country.
# GII Rank: The rank of the country based on the Gender Inequality Index (GII).
# Gender Inequality Index (GII): A composite measure reflecting inequality in achievements between women and men in three dimensions: reproductive health, empowerment, and the labor market.
# Mat.Mor: Maternal Mortality Ratio: The number of maternal deaths during pregnancy and childbirth per 100,000 live births.
# Ado.Birth: Adolescent Birth Rate: The number of births per 1,000 women aged 15-19.
# Parli.F: The percentage of seats held by women in the national parliament.
# Edu2.F: Population with Secondary Education (Female) 
# Edu2.M: Population with Secondary Education (Male)
# Edu2.FM: Female-to-Male Ratio of Secondary Education
# Labo.F: Female Labor Force Participation Rate
# Labo.M: Male Labor Force Participation Rate
# Labo.FM: Female-to-Male Ratio of Labor Force Participation

# Step 2
# "Exclude unneeded variables", keep the following columns
# "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"

kept_columns <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# Step 3
# "Remove all rows with missing values"
human <- filter(human, complete.cases(human))

# Step 4
# "Remove the observations which relate to regions instead of countries"
# The last 7 rows are regions and to be removed
human <- human[1:(nrow(human) - 7), ]

# "The data should now have 155 observations and 9 variable"
dim(human)
# [1] 155   9

# Step 5
# Save the human data in your data folder. You can overwrite your old ‘human’ data.
write_csv(human, "data/human.csv")

# This is the end of the Data Wrangling part of Week 5's assignment
# For "Analysis", please see course diary
