## Data Cleaning
## Load appropriate data frames

library(tidyverse)
library(magrittr)
library(psych)    ## helps with descriptive statistics
library(skimr)    ## gives a great overview of the dataset WITH PLOTS!!
library(jmv)      ## Provides us with various correlation tools

options(scipen=999,digits=3)

## STEP 1: Initial Exploratory Analysis

## The first step is to import data
## Read data into R
## View the data in R
df <- read.csv("C:\\Users\\redbe\\OneDrive\\Documents\\BeVera\\Bevera-R-master\\owid-covid-data.csv")
View(df)
glimpse(df)

## View the summary statistics for all the columns of the data frame
summary(df)

describe(df)

skim(df)

#### Use the pipeline operater in dplyr to select specific columns (%>%)

## Cleaning
## function select() ---columns
## function filter() ---rows
## function arrange() ---ascending or descending
## function mutate() ---add new columns to existing data
## function summarise() or group() ---reduce data by grouping

## Create a new df with the columns of interest
modified_df <- df %>% dplyr::select(location,new_cases_smoothed, new_deaths_smoothed, total_cases, total_deaths, population)

## Add columns of data wanted
df2 <- modified_df %>% mutate(limbo = total_cases-total_deaths)
View(df2)

skim(df2)

## Look at the correlation matrix between the relationships
corrMatrix(df2, vars = vars(new_cases_smoothed, new_deaths_smoothed, total_cases, total_deaths, population,limbo))

## Want to see the confidence interval?
corrMatrix(df2, vars = vars(new_cases_smoothed, new_deaths_smoothed, total_cases, total_deaths, population,limbo), ci = TRUE)


## Check for missing data dataframe
any(is.na(df2))

## Checking for the total number of missing values in the dataframe
sum(is.na(df2))

## Remove missing values from the dataframe
na.omit(df2)

## Remove outlier
df2 <- subset(df2, location!="World")

## Grouped by country averages
avg_df2 <- df2 %>% dplyr::group_by(location)%>% dplyr::summarise(avg_total_cases = mean(total_cases, na.rm = TRUE),                avg_total_deaths = mean(total_deaths, na.rm = TRUE),                                       avg_new_cases_smoothed = mean(new_cases_smoothed, na.rm = TRUE),
                                                avg_new_deaths_smoothed = mean(new_deaths_smoothed, na.rm = TRUE),
                                                avg_limbo = mean(limbo, na.rm = TRUE),
                                                avg_population = mean(population, na.rm = TRUE))
View(avg_df2)


