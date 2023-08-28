
#httr
#To get the current released version from CRAN:

#install.packages("httr")

#The aim of httr is to provide a wrapper for the curl package, customised to the demands of modern web APIs.
#most important http verbs: GET(), HEAD(), PATCH(), PUT(), DELETE() and POST()
#Response content is available with content() as a raw vector (as = "raw"), a character vector (as = "text"), 
#or parsed into an R object (as = "parsed"), 
#currently for html, xml, json, png and jpeg.
#You can convert http errors into R errors with stop_for_status()
#Config functions make it easier to modify the request in common ways: 
#set_cookies(),
#add_headers(), 
#authenticate(), 
#use_proxy(), 
#verbose(), 
#timeout(), 
#content_type(), 
#accept(), 
#progress().

#To get the current development version from github:
# install.packages("devtools")
devtools::install_github("r-lib/httr")

#Loading packages..

library(httr)
#Find OAuth settings for github: http://developer.github.com/v3/oauth/

oauth_endpoints("github")

#Register an application at https://github.com/settings/applications

myapp <- oauth_app("github",
                   key = "75ffc4989df8001de43a",
                   secret = "389877827ca7031f4586a37206816ec5152088dc")

#Get OAuth credentials

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#Use API

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)

#Find "datasharing"
datashare <- which(sapply(output, FUN=function(X) "datasharing" %in% X))
datashare

#Find the time that the datasharing repo was created.
list(output[[15]]$name, output[[15]]$created_at)

#sqldf

#The sqldf package allows for execution of SQL commands on R data frames.

#install.packages("sqldf", dep = TRUE)

#Loading packages

library(sqldf)

#Downloading file.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "acs.csv")

#Loading data.

acs <- read.csv("acs.csv")
head(acs)
detach("package:RMySQL", unload=TRUE)
sqldf("select pwgtp1 from acs where AGEP < 50")

#html

# Fetching data.
htmlUrl <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(htmlUrl)
close(htmlUrl)

#Viewing data.
head(htmlCode)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

#url
#Fetching data.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
SST <- read.fwf(fileUrl, skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))

#Viewing file.

head(SST)



