
# topic: discovery of handwashing, datacamp
# date: may 21, 2020
# ref: https://github.com/imsharvanj/Dr.-Semmelweis-and-the-discovery-of-handwashing

getwd()
setwd("C:/Users/mahdiebn/Google Drive/mycodes_dec/datacamp/discovery_handwashing")
library(tidyverse)
library(ggplot2)
library(dplyr)

yearly<- read.csv("yearly_deaths_by_clinic.csv")
print(yearly)

# add death rate
yearly$rate<- yearly$deaths/yearly$births
head(yearly)


# death rate in the clinics
yearly %>% ggplot(aes(year, rate, col= clinic))+
  geom_line()+
  theme_minimal()

#Why is the proportion of deaths constantly so much higher in Clinic 1? 

# let load the montly data to see if handwashing was the main culpirt

monthly <- read.csv("monthly_deaths.csv")
head(monthly)
  
monthly <- monthly %>% mutate(rate= deaths/births)
head(monthly)
     