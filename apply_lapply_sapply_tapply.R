library(tidyverse)
#apply(), lapply(), sapply(), tapply() Function in R with Examples

#apply(X, MARGIN, FUN)
#MARGIN:  take a value or range between 1 and 2 to define where to apply the function:
  #MARGIN=1`: the manipulation is performed on rows
#MARGIN=2`: the manipulation is performed on columns
#MARGIN=c(1,2)` the manipulation is performed on rows and columns
#FUN: tells which function to apply. Built functions like mean, median, sum, min, max and even user-defined functions can be applied>

m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
a_m1 <- apply(m1, 2, sum)
a_m1

#lapply() function
#lapply() function is useful for performing operations on list objects and returns a list object of same length of original set.
#lapply(X, FUN)
#Arguments:
  #X: A vector or an object
#FUN: Function applied to each element of x
# change the string value of a matrix to lower case with tolower function.

movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)

#We can use unlist() to convert the list into a vector.
movies_lower <-unlist(lapply(movies,tolower))
str(movies_lower)

#sapply() function
#sapply() function takes list, vector or data frame as input and gives output in vector or matrix.
#sapply() function does the same job as lapply() function but returns a vector.

#sapply(X, FUN)
#Arguments:
  #X: A vector or an object
#FUN: Function applied to each element of x

#We can measure the minimum speed and stopping distances of cars from the cars dataset.
dt <- cars
lmn_cars <- lapply(dt, min)
smn_cars <- sapply(dt, min)
lmn_cars
smn_cars

lmxcars <- lapply(dt, max)
smxcars <- sapply(dt, max)
lmxcars
smxcars

#We can use a user built-in function into lapply() or sapply()
avg <- function(x) {  
  ( min(x) + max(x) ) / 2}
fcars <- sapply(dt, avg)
fcars

#apply 
#apply(x, MARGIN, FUN) 
#apply to rows & columns of data frames/matrix, 
#output, vector, list, array

#lapply
#lapply(X, FUN)
#Apply a function to all the elements of the input, list, vector or data frame
# output is a list

#sapply
#sappy(X FUN)
#Apply a function to all the elements of the input, list, vector or data frame
#output vector or matrix

#slice vector
#We can use lapply() or sapply() interchangeable to slice a data frame.

below_ave <- function(x) {  
  ave <- mean(x) 
  return(x[x > ave])
}
dt_s<- sapply(dt, below_ave)
dt_l<- lapply(dt, below_ave)
identical(dt_s, dt_l)

#tapply() function
#tapply() computes a measure (mean, median, min, max, etc..) or a function for each factor variable in a vector.
#tapply(X, INDEX, FUN = NULL)
#Arguments:
  #X: An object, usually a vector
#INDEX: A list containing factor
#FUN: Function applied to each element of x
data(iris)
tapply(iris$Sepal.Width, iris$Species, median)

#split
#The split function splits a vector int groups using a factor.
#Using split and then applying a function with lapply produces the same resule as tapply:
x <- c(rnorm(10), runif(10), rnorm(10, 1))
x
f <- gl(3, 10)  # Generator factors
f
split(x, f)
lapply(split(x, f), mean)  # Instead of tapply


