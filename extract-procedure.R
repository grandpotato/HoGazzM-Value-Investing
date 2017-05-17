#So I can't figure out how to abstract a way. So I'll just write a procedure and refactor

years <- function(tables) dim(tables[[1]])[2]
extractDataLocation <- "extract/"


for(file in dir(extractDataLocation)) {
    filename <- filelist[grepl(stockcode,filelist)]
    
    
    #I need to make a class called stock information. Which is a list of another class which is the stock information by year.

    #Here I want to have a function to extract each individual value I want to pull out and insert it as a single row data frame
    
    source("SearchStrings.R")
    
    
    
    yearIndex <- 2
    maxyear <- years(tables)
    while(yearIndex <  maxyear) {
        thisyear <- StockInformation()
        thisyear <- initStockInformation(thisyear,tables,yearIndex)
    }
    dividends <- findItem(table, dividendsList,yearIndex)
    sharesOutstanding <- findItem(table, sharesOutstandinglist,yearIndex)
    revenue <- findItem(table, revenuelist,yearIndex)
    incomeTaxRate <- findItem(table, incomeTaxRatelist,yearIndex)
    netProfitBeforeAbnormals <- findItem(table, netProfitBeforeAbnormalslist,yearIndex)
    netProfit <- findItem(table, netProfitlist,yearIndex)
    longTermDebt <- findItem(table, longTermDebtlist,yearIndex)
    shareholdersEquity <- findItem(table, shareholdersEquitylist,yearIndex)
    EBITDA <- findItem(table, EBITDAlist,yearIndex)
    EBIT <- findItem(table, EBITlist,yearIndex)
    
    
    #make a stockInfomation class
    #populates attributes I need
    #has export function
}




