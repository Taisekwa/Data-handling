#Data Reshaping
#Joining Columns and Rows in a Data Frame
#using the cbind()function
#using rbind() function

# Create vector objects.
city <- c("Tampa","Seattle","Hartford","Denver")
state <- c("FL","WA","CT","CO")
zipcode <- c(33602,98104,06161,80294)

# Combine above three vectors into one data frame.
addresses <- cbind(city,state,zipcode)

# Print a header.
cat("# # # # The First data frame\n") 

# Print the data frame.
print(addresses)

# Create another data frame with similar columns
new.address <- data.frame(
  city = c("Lowry","Charlotte"),
  state = c("CO","FL"),
  zipcode = c("80230","33949"),
  stringsAsFactors = FALSE
)

# Print a header.
cat("# # # The Second data frame\n") 

# Print the data frame.
print(new.address)

# Combine rows form both the data frames.
all.addresses <- rbind(addresses,new.address)

# Print a header.
cat("# # # The combined data frame\n") 



# Combine rows form both the data frames.
all.addresses <- rbind(addresses,new.address)

# Print a header.
cat("# # # The combined data frame\n") 

# Print the result.
print(all.addresses)

#Merging Data Frames
library(MASS)
merged.Pima <- merge(x = Pima.te, y = Pima.tr,
                     by.x = c("bp", "bmi"),
                     by.y = c("bp", "bmi")
)
print(merged.Pima)
nrow(merged.Pima)

#Melting and Casting
library(MASS)
print(ships)

#Melt the Data
#Now we melt the data to organize it
#converting all columns other than type and year into multiple rows.
molten.ships <- melt(ships, id = c("type","year"))
print(molten.ships)

#Cast the Molten Data
#We can cast the molten data into a new form where the aggregate of each type of ship for each year is created.
#It is done using the cast() function.
recasted.ship <- dcast(molten.ships, type+year~variable,sum)
print(recasted.ship)
