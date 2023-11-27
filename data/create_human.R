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

colnames(gii)[colnames(gii) == ""] <- "Maternal Mortality Ratio"
colnames(gii)[colnames(gii) == ""] <- "Adolescent Birth Rate"

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
