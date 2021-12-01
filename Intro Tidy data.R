clean_data <- tribble(
  ~family, ~patient,
  "F1", 101,
  "F1", 102,
  "F2", 201
)

clean_data

patient <- tibble(
  subject_id = 1001:1006,
  gender_age = paste(c("m", "f"), 
  floor(runif(6, 21,65 )), sep="-"))

patient

#Key-value pairs
patient %>% separate(gender_age, c("sex", "age"), convert=TRUE)

#Input tibble
data_value <- 
  tibble(
    year = c(2015, 2014, 2014),
    month = c(11, 2, 4),
    day = c(23, 1, 30),
    value = c("high", "low", "low"))

data_value

#unite()
#No need to clean up old columns.
#Use package lubridate for working with dates.
date_unite <-  unite(data_value, 
date, year, month, day, 
sep = "-") 

date_unite

#Split with separate()
#Default split on non-alphanumeric characters
#Use quotes to designate columns since we are not refering to objects.
date_unite %>%
  separate(date, c("year", "month", "day"))

#Multiple values per cell
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

#Combinations of variables
patient_separate %>% 
  complete(subject_id, 
           nesting(visit_id))

#Detemine filling element as list
patient_separate %>% 
  complete(subject_id, 
           nesting(visit_id), fill = list(measured = 0))

#Use <NA>, not 0 for missing data in real life application.