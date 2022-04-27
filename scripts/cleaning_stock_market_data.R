#### Preamble ####
# Purpose: Clean the survey data downloaded from [https://datahub.io/core/s-and-p-500/datapackage.json]
# Author: Mohammad Sardar Sheikh 
# Data: 23 April 2022
# Contact: mohammad.sheikh@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - update this please



#reading in and cleaning the stock market data.
library(readxl)
library(tidyverse)
library(janitor)
library(lubridate)
stocks <- read_excel("inputs/data/ie_data.xls", 
                      sheet = "Data", col_types = c("text", 
                                                    "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                    "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                    "numeric", "numeric", "numeric", "numeric", 
                                                    "numeric", "numeric", "numeric", "numeric", 
                                                    "numeric", "numeric", "numeric"))

stocks <- stocks %>% select(-16)
stocks <- stocks %>% select(-14)
#gonna remove all the variables that have NA values included in them.

stocks <- stocks %>% na.omit()

stocks <- stocks %>% clean_names()
stocks <- stocks %>% rename(Date = stock_market_data_used_in_irrational_exuberance_princeton_university_press_2000_2005_2015_updated)
stocks <- stocks %>% rename(sandpcomposition = x2,
                            dividend = x3,
                            earnings = x4,
                            cpi = x5,
                            long_interest_rate = x7)

stocks <- stocks %>% select(-x6)

stocks <- stocks %>% rename(real_price = x8,
                            real_dividend = x9,
                            real_total_return_price = x10,
                            real_earnings = x11,
                            real_scaled_earnings = x12,
                            adjusted_pe_ratio = cyclically_13,
                            adjusted_total_return_price = cyclically_15,
                            cape_yield = x17,
                            monthly_bond_return = x18,
                            monthly_real_bond_return = x19,
                            tenyear_annualized_stock_return = x20,
                            tenyear_annualized_bond_return = x21,
                            tenyear_excess_annualized_returns = x22)

stocks <- stocks %>% rename(spcomp = sandpcomposition)

#still have to fix the date variable

#another way of getting the data
install.packages("jsonlite", repos="https://cran.rstudio.com/")
library("jsonlite")

json_file <- 'https://datahub.io/core/s-and-p-500/datapackage.json'
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

# get list of all resources:
print(json_data$resources$name)

# print all tabular data(if exists any)
for(i in 1:length(json_data$resources$datahub$type)){
  if(json_data$resources$datahub$type[i]=='derived/csv'){
    path_to_file = json_data$resources$path[i]
    data <- read.csv(url(path_to_file))
    print(data)
  }
}

data <- mutate(data, b1 = ymd(Date))
#remember to uncomment in the final script so that someone else can also run it. I also have to find a way to disguise this stuff

#write.csv(data, "scripts/cleaned_data.csv")
# write.csv(data, "outputs/paper/cleaned_data.csv")
write_csv(data, "outputs/paper/cleaned_data.csv")
#sending the code file to the shiny application
write_csv(data, "interactivegraphforpriceofindex/cleaned_data.csv")
#now i have to find out what the variables actually mean.
#all prices are in january 200 dollars  
#the enhancement is something that i can focus onm last\

