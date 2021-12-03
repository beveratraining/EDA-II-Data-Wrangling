
####################################################
#https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/airquality.html
#Daily air quality measurements in New York, May to September 1973.
#Daily readings of the following air quality values for May 1, 1973 (a Tuesday) to September 30, 1973.
#Ozone: Mean ozone in parts per billion from 1300 to 1500 hours at Roosevelt Island
#Solar.R: Solar radiation in Langleys in the frequency band 4000-7700 Angstroms from 0800 to 1200 hours at Central Park
#Wind: Average wind speed in miles per hour at 0700 and 1000 hours at LaGuardia Airport
#Temp: Maximum daily temperature in degrees Fahrenheit at La Guardia Airport.
#Month: Numeric value between 1-12
#Day: Numeric value between 1-31
#################################################

library(skimr)
library(dplyr)
library(tidyr)

data() 
data("airquality")
View(airquality)
str(airquality) #or glimpse(airquality)

#Perform EDA steps (and needed visuals)

summary(airquality) #all variables
summary(airquality$Temp) #one variable
skim(airquality)

colnames(airquality)

#Tidyr
#pivot_longer superseded gather() and pivot_wider superseded spread()

air.long <- gather(airquality, variable, value, -Month, -Day)
air.long <- pivot_longer(airquality, -c(Month,Day), names_to = "variable", values_to = "lifeExp")
head(air.long)

#air.wide <- spread(air.long, variable, value)
air.wide <- pivot_wider(air.long, names_from = "variable", values_from = "lifeExp")

head(air.wide)

#dplyr package
head(airquality)
ozone <- dplyr::select(airquality, Ozone, Month, Day) #select columns
head(september)
september <- dplyr::filter(airquality, Month==9, Temp>=90) #filter rows based on a condition

air_mess <- slice_sample(airquality, prop=.75)

air_chron <- arrange(air_mess, Month, Day) #arrange/re-arrange the order

airquality_C <- mutate(airquality, Temp_C = (Temp-32)*(5/9))
head(airquality_C) #create new column

#%>% CTRL SHIFT M Shortcut to create a pipe operator
june_C <- airquality %>% filter(Month==6) %>% mutate(Temp_C = (Temp-32)*(5/9))

month_sum <- airquality %>% group_by(Month) %>% dplyr::summarise(mean_Temp=mean(Temp), sd_Temp=sd(Temp))
head(month_sum)
#To remove NA values, use complete.cases() which will assign all NA as FALSE, else TRUE.
complete.cases(airquality) 
# TRUE indicates a complete row; FALSE indicates a row with at least one incomplete column

sum(complete.cases(airquality))

# Create new data without missing values
#To drop values option 1
airquality_complete <- airquality[complete.cases(airquality), ] 

#To drop values option 2
y<- na.omit(airquality)

# Find incomplete cases in a column
complete.cases(airquality$Ozone) # Identify observed values in the column Ozone

sum(complete.cases(airquality$Ozone)) 

Ozone_complete <- airquality$Ozone[complete.cases(airquality$Ozone)] # Exclude missing data
# from our column 

Ozone_complete <- airquality$Ozone[complete.cases(airquality$Ozone)]
Ozone_complete <- as.data.frame(Ozone_complete)
View(Ozone_complete)