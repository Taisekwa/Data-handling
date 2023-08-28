library(dplyr)
#dplyr is an iteration of plyr that provides a flexible "verb" based functions to manipulate data in R. 
#Aggregating with %>% (pipe) operator
library(dplyr)
library(tidyverse)
library(magrittr)
df <- mtcars
df$cars <- rownames(df) #just add the cars names to the df
df <- df[,c(ncol(df),1:(ncol(df)-1))] # and place the names in the first column

#1. Sumarize the data

#To compute statistics we use summarize and the appropriate functions. 
#In this case n() is used for counting the number of cases.
df %>%
  summarize(count=n(),mean_mpg = mean(mpg, na.rm = TRUE),
            min_weight = min(wt),max_weight = max(wt))


#2. Compute statistics by group
df %>%
  group_by(cyl, gear) %>%
  summarize(count=n(),mean_mpg = mean(mpg, na.rm = TRUE),
            min_weight = min(wt),max_weight = max(wt))

#Syntax commonalities
#The first argument to all these functions is always a data frame
#Columns can be referred directly using bare variable names (i.e., without using $)
#These functions do not modify the original data itself, i.e., they don't have side effects. 
# Hence, the results should always be saved to an object.
#Before converting the type of mtcars to tbl_df (since it makes printing cleaner
#we add the rownames of the dataset as a column using rownames_to_column function from the tibble package.

mtcars_tbl <- as_tibble(rownames_to_column(mtcars, "cars"))
# examine the structure of data
head(mtcars_tbl)

#FILTER
#filter helps subset rows that match certain criteria, to select rows by position use slice
#slice takes only 2 arguments, the first argument is the name of the data.frame and
#the second (and subsequent) arguments are the criteria that filter the data 
#(these criteria should evaluate to either TRUE or FALSE)
slice(mtcars_tbl, 6:9)
slice(mtcars_tbl, -c(1:5, 10:n())) 

#Arrange
#arrange is used to sort the data by a specified variable(s).
#the first argument is a data.frame
#and consequent arguments are used to sort the data.
#If more than one variable is passed, the data is first sorted by the first variable,
#and then by the second variable, and so on..

arrange(mtcars_tbl, hp)
#To arrange the data by miles per gallon - mpg in descending order, followed by number of cylinders - cyl:
arrange(mtcars_tbl, desc(mpg), cyl)

# Select
#select is used to select only a subset of variables.
#To select only mpg, disp, wt, qsec, and vs from mtcars_tbl:
select(mtcars_tbl, mpg, disp, wt, qsec, vs)
#: notation can be used to select consecutive columns
#To select columns from cars through disp and vs through carb:
select(mtcars_tbl, cars:disp, vs:carb)
select(mtcars_tbl, -(hp:qsec))
#To make life easier, there are a number of helper functions
#(such as starts_with(), ends_with(), contains(), matches(), num_range(), one_of(), and everything()) that can be used in select
#To learn more ?select_helpers and ?select 
#quotes should be used while referring to columns in helper functions
select(mtcars_tbl, cylinders = cyl, displacement = disp) 
#To rename columns without dropping other variables, use rename
rename(mtcars_tbl, cylinders = cyl, displacement = disp)

#Mutate
#mutate can be used to add new columns to the data.
mutate(mtcars_tbl, weight_ton = wt/2, weight_pounds = weight_ton * 2000)
#To retain only the newly created columns, use transmute instead of mutate:
transmute(mtcars_tbl, weight_ton = wt/2, weight_pounds = weight_ton * 2000)


#Summarise
#summarise calculates summary statistics of variables by collapsing multiple values to a single value.
summarise(mtcars_tbl, mean_mpg = mean(mpg), sd_mpg = sd(mpg), 
          mean_disp = mean(disp), sd_disp = sd(disp))
#sd=a quantity expressing by how much the members of a group differ from the mean value for the group.

#Group_by
by_cyl <- group_by(mtcars_tbl, cyl)
summarise(by_cyl, mean_mpg = mean(mpg), sd_mpg = sd(mpg))

#Putting it all together
selected <- select(mtcars_tbl, cars:hp, gear)
ordered <- arrange(selected, cyl, desc(mpg))
by_cyl <- group_by(ordered, gear)
filter(by_cyl, mpg > 20, hp > 75)

mtcars_tbl %>% 
  select(cars:hp) %>% 
  arrange(cyl, desc(mpg)) %>%
  group_by(cyl) %>% 
  filter(mpg > 20, hp > 75)

#Summarise multiple columns

#To find the number of distinct values for each column:
mtcars_tbl %>% 
  summarise_all(n_distinct)

#To find the number of distinct values for each column by cyl
mtcars_tbl %>% 
  group_by(cyl) %>% 
  summarise_all(n_distinct)

#To summarise specific multiple columns, use summarise_at
mtcars_tbl %>% 
  group_by(cyl) %>% 
  summarise_at(c("mpg", "disp", "hp"), mean)

#To apply multiple functions, either pass the function names as a character vector:

mtcars_tbl %>% 
  group_by(cyl) %>% 
  summarise_at(c("mpg", "disp", "hp"), 
               c("mean", "sd"))

#or wrap them inside funs:
mtcars_tbl %>% 
  group_by(cyl) %>% 
  summarise_at(c("mpg", "disp", "hp"), 
               funs(mean, sd))

#Select a subset of rows in a data frame that meet a logical criteria:
#dplyr::filter() - Select a subset of rows in a data frame that meet a logical criteria:
dplyr::filter(iris,Sepal.Length>7)

#dplyr::distinct() - Remove duplicate rows:
distinct(iris, Sepal.Length, .keep_all = TRUE)



