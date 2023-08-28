
#Subsetting Data
library(tidyverse)

library(region5air)
data(chicago_air)

#You can specify the number of lines to display by using the n = parameter
head(chicago_air, n = 3)

#You can also look at the bottom of the data frame by using tail()
tail(chicago_air)

#The table function is helpful for summarizing your data by counts
#and the plot() 
#and hist() functions allow you to quickly visualize the data

table(chicago_air$ozone)  ##Summarizes by counts
plot(chicago_air$ozone)  # Quick plot of data
hist(chicago_air$ozone)  #Like a historgram plot except no binning occurs

#Indexing
#in R the index is [rows,columns]
chicago_air[5,3] ## This should grab the value associated with the fifth row and the third column

x <- c(1, 3, 2, 7, 25.3, 6)
x[5]  # This will access the fifth element in the vector

#Subsetting using indexing
chicago_air[1, ]#it returns all the columns associated with row number 1.

chicago_air[c(1, 2, 5), ] #Accesses the 1, 2 and 5th rows of data

#Remember, the convention is [rows, columns]

chicago_air[, 1] #it to return all rows associated with column 1.

chicago_air[, c(3, 4, 6)] #You can obtain more than one column by supplying a vector of column numbers

chicago_air[, "solar"] #Column names can also be used
chicago_air[, c("ozone", "temp", "month")]
chicago_air[1:5, 3:5]  # Returns the values associated with the first 5 rows of data and the third through fifth columns.

#subsetting with logical operators.
aq[(aq$ozone > .070), ]  # This returns all the days with readings above .070 ppm

#f we wanted all of the days in the 7th month, we could use ==
aq[(aq$month == 7), ]
aq[(aq$temp >= 80 & aq$temp <= 85), ] #We can combine logical conditions with & (and operator)

#Subsetting using the subset()
high.temp <- subset(aq, temp > 90)  # Using subset you can refer to the name of the column without using the $ operator.  
#To save the information you need to assign it a variable name

#Sorting data in base R
sort.oz <- chicago_air[order(chicago_air$ozone),] # sort the dataset by ozone in ascending order

sort.oz.sol <- with(chicago_air, chicago_air[order(ozone, solar),])  # sort the data first by ozone and then by solar radiation

sort.oz.sol2 <- with(chicago_air, chicago_air[order(ozone, -solar),])   # sort the data first by ozone in ascending order, then by solar radiation in descending order

#The rbind function requires that there are an equal number of columns
combo <- rbind(sort.oz.sol, sort.oz.sol2)

install.packages("plyr")
library(plyr)
rbind.fill(oz.viol, aq.sub)


cbind(aq.sub,oz.viol)  # the row numbers of the datasets need to be equal or the data will be recycled from the shorter dataset.
