
# topic: discovery of handwashing, datacamp
# date: may 21, 2020
# ref: https://rpubs.com/iPhuoc/semmelweis_handwashing


#get set wd
getwd()
setwd("C:/Users/-----")

# load libraries 
library(tidyverse)
library(ggplot2)
library(dplyr)
library(purrr)
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
monthly <- monthly %>% mutate(rate= deaths/births)

monthly %>% ggplot(aes(as.Date(date), rate))+
  geom_line()+
  theme_minimal()


# From this date handwashing was made mandatory
handwashing_start = as.Date('1847-06-01')

# Add a TRUE/FALSE column to monthly called handwashing_started
# way 1
hadwashing <- function (x)
{
  if (as.date(x)( "1847-06-01")){
    print ('Yes')
  } else{
    print ("no")
  }
}
monthly$date <- as.Date(monthly$date)
monthly$handwashing<- map(monthly$date, hadwashing)
head(monthly)


# way 2: easier
monthly<-monthly %>%
  mutate(handwashing2= ifelse(date> handwashing_start, T, F) )
monthly 

monthly %>% ggplot(aes(date, rate, col= handwashing2))+
  geom_line()+ 
  theme_minimal()

#How much did it reduce the monthly proportion of deaths on average?
# Calculating the mean proportion of deaths 
# before and after handwashing.
monthly %>% group_by(handwashing2) %>% summarise(mean= mean(rate))
# Calculating a 95% Confidence intrerval using t.test 
test_res<- t.test(monthly$rate~ monthly$handwashing2, monthly  )
test_res






