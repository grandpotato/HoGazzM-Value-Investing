OneYearFinancials <- setClass("OneYearFinancials",
                             slots = c(date = "Date",
                                       dividends = "numeric",
                                       sharesOutstanding = "numeric",
                                       revenue = "numeric",
                                       incomeTaxRate = "numeric",
                                       netProfitBeforeAbnormals = "numeric",
                                       netProfit = "numeric",
                                       longTermDebt = "numeric",
                                       shareholdersEquity = "numeric",
                                       EBITDA = "numeric",
                                       EBIT = "numeric"
                                 
                             )
                     )
                             
                            

StockInformation <- setClass("StockInformation",
                             slots = c(stockcode = "character",
                                       dataAccessDate = "Date",
                                       OneYearFinancials = "list"
                                       
                             ),
                             prototype = list(stockcode = "QQQ",
                                           dataAccessDate = Sys.Date(),
                                           OneYearFinancials = list()
                             )
                             )

setGeneric(name = "initStockInformation",
           def = function(Object, stockFile)
           {
               standardGeneric("initStockInformation")
           }
        )

setMethod(f = "initStockInformation",
          signature = c("StockInformation","char"),
          definition = function(Object, stockFile)
          {
              #Here I want to have a function to extract each individual value I want to pull out and insert it as a single row data frame
              Object@stockcode <- loadStockCode(stockFile)
              Object@dataDate <- loadFileDate(stockFile)
              Object@OneYearFinancials <- loadFinancials(stockFile)
              
             return(Object)
          }
          )

loadStockCode <- function(stockFile)
{
    return(sub("[0-9]*\\s[0-9]*\\s([A-Z]*).txt","\\1",stockFile))
}

loadFileDate <- function(stockFile)
{
    as.Date(sub("([-0-9]*)\\s.*","\\1",paste(format(Sys.Date()),filename)))
}

setGeneric(name = "loadFinancials",
           def = function(stockInfo, stockFile)
               {
                   standardGeneric(stockInfo, stockFile)    
           }
           )

setMethod(f = "loadFinancials",
          signature = "character",
          definition = function(stockInfo, stockFile)
          {
                allFinancials <- vector("list",dim(table[[1]])[2] -1)
                tables <- getFinancialTables(stockFile)
                
                
                source("SearchStrings.R")
                yearIndex <- 2
                
                
                while(yearIndex < dim(table[[1]])[2] ) 
                    {
                    financials <- OneYearFinancials()
                    financials@dividends <- findItem(table, dividendsList,yearIndex)
                    financials@sharesOutstanding <- findItem(table, sharesOutstandinglist,yearIndex)
                    financials@revenue <- findItem(table, revenuelist,yearIndex)
                    financials@incomeTaxRate <- findItem(table, incomeTaxRatelist,yearIndex)
                    financials@netProfitBeforeAbnormals <- findItem(table, netProfitBeforeAbnormalslist,yearIndex)
                    financials@netProfit <- findItem(table, netProfitlist,yearIndex)
                    financials@longTermDebt <- findItem(table, longTermDebtlist,yearIndex)
                    financials@shareholdersEquity <- findItem(table, shareholdersEquitylist,yearIndex)
                    financials@EBITDA <- findItem(table, EBITDAlist,yearIndex)
                    financials@EBIT <- findItem(table, EBITlist,yearIndex)
                    
                    allFinancials[[yearIndex-1]] <- financials
                    yearIndex <- yearIndex + 1
                }

                
                return()
          }
)
#tables are assumed to have rownames in the first column
findItem <- function(table,target, yearIndex)
{
    rowNum <- which(table[,1] %in% target)
    item <- table[rowNum,][yearIndex][[1]]
    item <- cleanItem(item)
}

#text cleaning function for how items are read out of tables
cleanItem <- function(item) {
    item <- as.character(item)
    item <- gsub("[^0-9\\.]","",item)
    item <- as.numeric(item)
    
}

getFinancialTables <- function(filename){
    conn <- file(paste("extract/",filename,sep = ""),"r")
    rawtext <- readLines(conn)
    close(conn)
    
    library(XML)
    HTMLtext <- htmlParse(rawtext)
    tables <- readHTMLTable(HTMLtext)
    return(tables)
    
}
