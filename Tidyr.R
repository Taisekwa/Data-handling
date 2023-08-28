
#tidyr
#The goal of tidyr is to help you create tidy data. Tidy data is data where:
#Each variable is in a column.
#Each observation is a row.
#Each value is a cell.
#Tidy data describes a standard way of storing data that is used wherever possible throughout the tidyverse.

#Installation
# The easiest way to get tidyr is to install the whole tidyverse:
#install.packages("tidyverse")

# Alternatively, install just tidyr:
#install.packages("tidyr")

# Or the development version from GitHub:
# install.packages("devtools")
#devtools::install_github("tidyverse/tidyr")

library(tidyr)

#There are two fundamental verbs of data tidying:
#gather() takes multiple columns, and gathers them into key-value pairs: it makes "wide" data longer.

#spread() takes two columns (key & value), and spreads into multiple columns: it makes "long" data wider.

#tidyr also provides separate() 
#and extract() functions which makes it easier to pull apart a column that represents multiple variables.
#The complement to separate() is unite()

#Let's generate some data to help explain this concept
set.seed(1)
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 20, 1),
  Y = rnorm(10, 20, 2),
  Z = rnorm(10, 20, 4)
)
stocks 

stocksL <- gather(data = stocks, key = stock, value = price, X, Y, Z)
stocksL

#-time, means all columns except time contain the key-value pairs.

gather(stocks, stock, price, -time)

head(gather(stocks, stk, pr, -time))

#The tidyr package description states that it's "an evolution of 'reshape2'"

#testing
install.packages("reshape2") # if not already installed
library(reshape2)
melt(stocks, measure.vars = c("X","Y","Z"), variable.name = "stock", value.name = "price")

head(stocksL)

spread(data = stocksL, key = stock, value = price)
#The reshape2 package has a function that does this called dcast. 
#It's a little more complicated to use than spread
dcast(stocksL, time ~ stock, value.var = "price")

#The way this works with a dplyr data pipeline is as follows:
stocks %>% 
  gather(stock,price,X:Z)%>% 
  group_by(stock) %>% 
  summarise(min = min(price), max = max(price))

#For comparison, here is the same thing carried out with the base R aggregate function:
stocksL <- gather(stocks, stock, price, X, Y, Z)
aggregate(price ~ stock, data = stocksL, function(x)c(min=min(x),max=max(x)))
