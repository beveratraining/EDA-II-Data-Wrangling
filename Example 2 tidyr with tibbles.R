library(tidyr)
library(dplyr)
library(magrittr)

# Tibble is the central data structure for the set of packages known as the tidyverse. Tibbles are data frames, but they tweak some older behaviors.
# vignette("tibble")

# Creating a tibble using tribble() function.
# Creating tribble() is a row-wise, readable tibble. This is useful for   creating small tables of data
clean_data <- tibble::tribble(~family, ~patient,
  "F1", 101,
  "F1", 102,
  "F2", 201
)

clean_data
# The tbl_df (tibble diff) class is a subclass of data.frame, created in   order to have different default behavior. The colloquial term "tibble"   refers to a data frame that has the tbl_df class. 

patient <- tibble(
  subject_id = 1001:1006,
  gender_age = paste(c("m", "f"), 
  floor(runif(6,21,65)), sep="-"))

patient

# Key-value pairs: set of two linked data items: a key, which is a unique identifier for some item of data, and the value, which is either the data that is identified or a pointer to the location of that data.
# Convert=TRUE, useful if the component columns are integer, numeric or logical.
patient %>% separate(gender_age, c("sex", "age"), convert=TRUE)

# Input tibble
data_value <- 
   tibble(
   year = c(2015, 2014, 2014),
   month = c(11, 2, 4),
   day = c(23, 1, 30),
   value = c("high", "low", "low"))

data_value

# unite()
# No need to clean up old columns.
# Use package lubridate for working with dates.

date_unite <-  unite(data_value, 
           date, year, month, day, 
           sep = "-") 

date_unite

# Split with separate()
# Default split on non-alphanumeric characters
# Use quotes to designate columns since we are not referring to objects.
date_unite %>%
  separate(date, c("year", "month", "day"))

# Multiple values per cell
patient_df <- tibble(
  subject_id = 1001:1003, 
  visit_id = c("1,2,3", "1,2", "1"),
  measured = c("9,0,11", "11,3" , "12")
  )
patient_df

#Combinations of variables
patient_df %>% 
  separate_rows(visit_id, measured, convert=TRUE) -> patient_separate

patient_separate

# Combinations of variables
patient_separate %>% 
  complete(subject_id, 
           nesting(visit_id)) #nesting - chaning hierarchy 

# Determine filling element as list
patient_separate %>% 
  complete(subject_id, 
           nesting(visit_id), fill = list(measured = NA))

#Use <NA>, not 0 for missing data in real life application.