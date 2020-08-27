
# load and pre-process gapminder.csv (or your own data) here
# Note: don't do filtering based on reactive values (inputs etc) here, do that in server
# example: gapminder <- read.csv("data/gapminder.csv", header = TRUE)



library(tidyr)

# Set working directory..
setwd("/cloud/project/challenge/data")

# Read in gapminder CSV data and convert data with less than friendly column 
# names into names that are easy to work with.
csv_data <- clean_names(
              read.csv("gapminder_C.csv", header = TRUE))

# Dataset column names.
colOptions <- setdiff(names(csv_data), "columns")
# colOptions <- c(setdiff(names(csv_data), "columns"))

# Drop rows containing missing values.
drop_na(csv_data)


#-------------------------------------------------------------------------------
  
  # library(janitor)
  
  # Remove all rows and/or columns that are composed entirely of NA values.
  # remove_empty(rds_data)
  
  # looking at missing values
  # rds_data$year
  # is.na(rds_data$year)
  
  # counting missing values
# rds_data %>%
#   summarise(count = sum(is.na(year)))