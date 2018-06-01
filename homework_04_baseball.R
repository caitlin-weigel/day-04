# Homework Day 04, Question 3
# Caitlin Weigel | caitlinweigel@college.harvard.edu
# 

# 3. Malcolm Gladwell: "The cutoff date for almost all nonschool baseball leagues in the United States is July 31, with the result that more major league players are born in August than in any other month." Gather data to support or refute this statement.

# Since there wasn't a table with all the MLB players and their birthdays, I decided to narrow based on birthplace. I chose to look at all the baseball players born in Florida as 535 was a relatively large pool of players. I read that table into the dataframe birthdays.
URL_BASEBALL = "https://www.baseball-reference.com/bio/FL_born.shtml"

birthdays = read_html(URL_BASEBALL) %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(trim = TRUE)

# There was a lot of extraneous details on the table such as actual baseball stats of the players (who cares about that?), so I selected only the Birthdate column.
birthdays = birthdays %>% select(Birthdate)

# I then separated the birthdate, which was in the form "month day, year", into three columns, one for month, day, and year.
birthdays = separate(birthdays, Birthdate, c("month", "day", "year"), sep = " ")

# Grouping by month, I was able to count up how many players were born in each month.
birthmonth = birthdays %>% 
  group_by(month) %>% 
  count(month)

# As seen by the resulting table, more baseball players (born in Florida), were born in August than in any other month. Though, this might not be statistically significant...
birthmonth

