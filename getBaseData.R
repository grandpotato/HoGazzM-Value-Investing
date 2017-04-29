#This script builds a data frame of all listed ASX companies
#I need to work out how to store global variables for like data storage locations. Updating will become a pain in the ass if I don't. 09/03/17

getASXCompanies <- function(){
    library(dplyr)

    csvASXList <- read.csv("./data/ASXListedCompanies.csv", skip = 2)
    
    tbl_df(csvASXList)
    
    
}

updateASXListingData <- function() {
    
    #ASX Listings From http://www.asx.com.au/prices/company-information.htm "download directory" as of 09/03/17
    location <- "http://www.asx.com.au/asx/research/ASXListedCompanies.csv"
    
    download.file(location, "./data/ASXListedCompanies.csv")
}


getASXListingDate <- function() {
    #This method grabs the date from the ASXListedCompanies file as state on the first line of the file    
    strDateLine <- readLines("./data/ASXListedCompanies.csv",1)
    
    strsplit(strDateLine, "ASX listed companies as at ")[[1]][2]
    #convert this to a date later
}
