library(skimr)
library(dplyr)
library(tidyr)

data() 
data("airquality")
View(airquality)
str(airquality) #or glimpse(airquality)

#Perform EDA steps (and needed visuals)

summary #all variables
summary(airquality$Temp) #one variable
skim(airquality)

colnames(airquality)

#Tidyr
#pivot_longer superseded gather() and pivot_wider superseded spread()

#air.long <- gather(airquality, variable, value, -Month, -Day)
air.long <- pivot_longer(airquality, -c(Month,Day), names_to =                      "variable", values_to = "lifeExp")
head(air.long)

#air.wide <- spread(air.long, variable, value)
air.wide <- pivot_wider(air.long, names_from = "variable", values_from =             "lifeExp")

head(air.wide)

#dplyr package
head(airquality)
ozone <- dplyr::select(airquality, Ozone, Month, Day) #select columns

september <- dplyr::filter(airquality, Month==9, Temp>=90) #filter rows based on a condition

air_mess <- slice_sample(airquality, prop=.75)

air_chron <- arrange(air_mess, Month, Day) #arrange/re-arrange the order

airquality_C <- mutate(airquality, Temp_C = (Temp-32)*(5/9))
head(airquality_C) #create new column

#%>% CTRL SHIFT M Shortcut to create a pipe operator
june_C <- airquality %>% filter(Month==6) %>% mutate(Temp_C = (Temp-32            )*(5/9))

month_sum <- airquality %>% group_by(Month) %>% dplyr::summarise                 (mean_Temp=mean(Temp), sd_Temp=sd(Temp))

