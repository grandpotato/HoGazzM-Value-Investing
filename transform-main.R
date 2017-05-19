#So I can't figure out how to abstract a way. So I'll just write a procedure and refactor
source("ClassStockInformation.R")
source("helpers.R")
years <- function(tables) dim(tables[[1]])[2]
extractDataLocation <- "extract/"
loadingLocation <- "loading/"

extractedFiles <- dir(extractDataLocation,pattern = ".*[[:punct:]]txt")

for(filename in extractedFiles) {
    data <- StockInformation()
    data <- tryCatch({initStockInformation(data, filename)},error = function(e){paste(Sys.time(),filename,warnings())})
    if(class(data) != "character")
        {
        exportStockToCSV(data, loadingLocation)
        file.rename(paste("extract/",filename,sep=""),paste("extract/processed/",filename,sep=""))
    }
    
    
    
    #I need to make a class called stock information. Which is a list of another class which is the stock information by year.

    #Here I want to have a function to extract each individual value I want to pull out and insert it as a single row data frame
    
    
    

}




