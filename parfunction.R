# R multiple plots
#R par() function
#multiple graphs in a single plot by setting some graphical parameters with the help of par()
#Graphical parameter mfrow
#It takes in a vector of form c(m, n)
#which divides the given plot into m*n array of subplots.
#we would have m=1 and n=2.
#>max.temp    # a vector used for plotting
#Sun Mon Tue Wen Thu Fri Sat 
#22  27  26  24  23  26  28
par(mfrow=c(1,2))    # set the plotting area into a 1*2 array
barplot(max.temp, main="Barplot")
pie(max.temp, main="Piechart", radius=1)

#This same phenomenon can be achieved with the graphical parameter mfcol.
#The only difference between the two is that, 
#mfrow fills in the subplot region row wise while mfcol fills it column wise.

Temperature <- airquality$Temp
Ozone <- airquality$Ozone
par(mfrow=c(2,2))
hist(Temperature)
boxplot(Temperature, horizontal=TRUE)
hist(Ozone)
boxplot(Ozone, horizontal=TRUE)