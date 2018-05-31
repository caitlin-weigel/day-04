## Day 04 homework
## Caitlin Weigel

# Libraries
library(dplyr)
library(tidyr)
library(stringr)
library(rvest)

#1. Scrape the current temperature and weather conditions for Cape Town from https://www.accuweather.com.
#
URL_WEATHER = "https://www.accuweather.com/en/za/cape-town/306633/weather-forecast/306633"

temp = read_html(URL_WEATHER) %>% 
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "c", " " ))]//*[contains(concat( " ", @class, " " ), concat( " ", "cond", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "c", " " ))]//*[contains(concat( " ", @class, " " ), concat( " ", "large-temp", " " ))] | //*[contains(concat( " ", @class, " " ), concat( " ", "i-6-xl", " " ))]') %>% 
  html_text()

temp

#2. Generate a data frame with all guest stars to have appeared on The Simpsons.
URL_SIMPSONS = "https://en.wikipedia.org/wiki/List_of_The_Simpsons_guest_stars"

guest_stars = read_html(URL_SIMPSONS) %>% 
  html_nodes("table") %>% 
  .[[2]] %>% 
  html_table(trim = TRUE, fill = TRUE)

# I'M SO PROUD OF MYSELF FOR DOING THIS WOOO

#3. Malcolm Gladwell: "The cutoff date for almost all nonschool baseball leagues in the United States is July 31, with the result that more major league players are born in August than in any other month." Gather data to support or refute this statement.

URL_BASEBALL = "https://www.baseball-reference.com/bio/FL_born.shtml"

birthdays = read_html(URL_BASEBALL) %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(trim = TRUE)

birthdays = birthdays %>% select(Birthdate)

birthdays = separate(birthdays, Birthdate, c("month", "day", "year"), sep = " ")

birthdays %>% 
  group_by(month) %>% 
  count(month)
 