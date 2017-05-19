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
                                       EBIT = "numeric",
                                       totalCurrentAssets = "numeric",
                                       totalCurrentLiabilities = "numeric"
                                 
                             )
                     )
                             
                            

StockInformation <- setClass("StockInformation",
                             slots = c(stockcode = "character",
                                       dataAccessDate = "Date",
                                       Financials = "list"
                                       
                             ),
                             prototype = list(stockcode = "QQQ",
                                           dataAccessDate = Sys.Date(),
                                           Financials = list()
                             )
                             )

setGeneric(name = "initStockInformation",
           def = function(Object, stockFile)
           {
               standardGeneric("initStockInformation")
           }
        )

setMethod(f = "initStockInformation",
          signature = c("StockInformation","character"),
          definition = function(Object, stockFile)
          {
              #Here I want to have a function to extract each individual value I want to pull out and insert it as a single row data frame
              Object@stockcode <- loadStockCode(stockFile)
              Object@dataAccessDate <- loadFileDate(stockFile)
              Object@Financials <- loadFinancials(stockFile)
              
             return(Object)
          }
          )

loadStockCode <- function(stockFile)
{
    return(sub("[-0-9]*\\s[0-9]*\\s([A-Z0-9]*).txt","\\1",stockFile))
}

loadFileDate <- function(stockFile)
{
    as.Date(sub("([-0-9]*)\\s.*","\\1",stockFile))
}

setGeneric(name = "loadFinancials",
           def = function(stockFile)
               {
                   standardGeneric("loadFinancials")    
           }
           )

setMethod(f = "loadFinancials",
          signature = "character",
          definition = function(stockFile)
          {

                tables <- getFinancialTables(stockFile)
                errorDescription <- 0
                if(length(tables) == 0)
                    {
                        errorDescription <- paste(Sys.time(),"Stockcode",loadStockCode(stockFile),"does not exist.")
                        write(errorDescription,file="logs/transform.log",append=TRUE)
                        print(errorDescription)
                    } else {
                    
                    allFinancials <- vector("list",dim(tables[[1]])[2] -1)
                    
                    companyHistoricals <- findCompanyHistoricals(tables)
                    historicalFinancials <- findHistoricalFinancials(tables)
                    balanceSheet <- findBalanceSheet(tables)
                    
                    source("SearchStrings.R")
                    
                    
                    yearIndex <- 2
                    
                    while(yearIndex <= dim(tables[[1]])[2]) 
                        {
                        financials <- OneYearFinancials()
                        financials@date <-  as.Date(paste(sub("\\n *([0-9]{4}/[0-9]{2}).*","\\1",names(companyHistoricals)[yearIndex]),"/01",sep=""))
                        financials@dividends <- findItem(companyHistoricals, dividendslist,yearIndex)
                        financials@sharesOutstanding <- findItem(companyHistoricals, sharesOutstandinglist,yearIndex)
                        financials@revenue <- findItem(historicalFinancials, revenuelist,yearIndex)
                        financials@incomeTaxRate <- findItem(historicalFinancials, incomeTaxRatelist,yearIndex)
                        financials@netProfitBeforeAbnormals <- findItem(historicalFinancials, netProfitBeforeAbnormalslist,yearIndex)
                        financials@netProfit <- findItem(historicalFinancials, netProfitlist,yearIndex)
                        financials@longTermDebt <- findItem(historicalFinancials, longTermDebtlist,yearIndex)
                        financials@shareholdersEquity <- findItem(historicalFinancials, shareholdersEquitylist,yearIndex)
                        financials@EBITDA <- findItem(historicalFinancials, EBITDAlist,yearIndex)
                        financials@EBIT <- findItem(historicalFinancials, EBITlist,yearIndex)
                        financials@totalCurrentAssets <- as.numeric(NA)
                        financials@totalCurrentLiabilities <- as.numeric(NA)
    
                        
                        allFinancials[[yearIndex-1]] <- financials
                        yearIndex <- yearIndex + 1
                    }
    
                    yearIndex <- 2
                    
                        while (yearIndex <= dim(balanceSheet)[2]) {
                            
                            balanceyear <- as.numeric(sub("\\n *([0-9]{4}).*","\\1",names(balanceSheet)[yearIndex]))
                            financialsIndex <- 1
                            while(financialsIndex <= length(allFinancials)) {
                                
                                slotyear <- lubridate::year(allFinancials[[financialsIndex]]@date)
                                
                                if(slotyear == balanceyear)
                                {
                                    allFinancials[[financialsIndex]]@totalCurrentAssets <- findItem(balanceSheet, totalCurrentAssetslist, yearIndex)
                                    allFinancials[[financialsIndex]]@totalCurrentLiabilities <- findItem(balanceSheet, totalCurrentLiabilitieslist, yearIndex)
                                }
                                
                                financialsIndex <- financialsIndex +1
                            }
                            
                            
                            yearIndex <- yearIndex + 1
                        }
                    return(allFinancials)
                }
                return(errorDescription)
          }
)
#tables are assumed to have rownames in the first column
findItem <- function(table,target, yearIndex)
{
    rowNum <- which(table[,1] %in% target)
    item <- table[rowNum,][yearIndex][[1]]
    item <- cleanItem(item)
    item <- valueOrNA(item)
    item <- as.numeric(item)
    return(item)
}

valueOrNA <- function(value)
{
    if(length(value) == 0)
    {
        value <- NA
    }
    return(value)
    
    
}   

#text cleaning function for how items are read out of tables
cleanItem <- function(item) {
    item <- as.character(item)
    item <- gsub("[^-0-9\\.]","",item)
    item <- as.numeric(item)
    return(item)
    
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

setGeneric(name = "exportStockToCSV",
           def = function(x, loadingLocation)
               {
                    standardGeneric("exportStockToCSV")
               }
            )

setMethod(f= "exportStockToCSV",
          signature = c("StockInformation","character"),
          definition = function(x, loadingLocation)
          {
              loadingLocation <- "loading/"
              data <- 0
              for(financial in x@Financials)
              {
                  record <- data.frame(x=c(x@stockcode,
                                     as.character(x@dataAccessDate),
                                     as.character(financial@date),
                                     financial@dividends,
                                     financial@sharesOutstanding,
                                     financial@revenue,
                                     financial@incomeTaxRate,
                                     financial@netProfitBeforeAbnormals,
                                     financial@netProfit,
                                     financial@longTermDebt,
                                     financial@shareholdersEquity,
                                     financial@EBITDA,
                                     financial@EBIT,
                                     financial@totalCurrentAssets,
                                     financial@totalCurrentLiabilities
                                     )
                                   )
                  
                  if(is.numeric(data))
                  {
                      data <- record
                  } else {
                      data <- bind_cols(data, record)
                  }
                      
                 
              }
              row.names(data) <- c("Company_Name",
                                   "AccessDate",
                                   "Date",
                                   "Dividends",
                                   "Shares_Outstanding",
                                   "Revenues",
                                   "Income_Tax_Rate",
                                   "Net_Profit_Before_Abnormals",
                                   "Net_Profit",
                                   "Long_term_debt",
                                   "Shareholders_Equity",
                                   "EBITDA",
                                   "EBIT",
                                   "Total_Current_Assets",
                                   "Total_Current_Liabilities")
              
              data <-t(data)
              write.table(data,file = paste(loadingLocation,format(Sys.Date())," ",x@stockcode,".csv",sep=""),sep=",", row.names = FALSE)
          }
          )
          
valueOrNA <- function(value)
    {
        if(length(value) == 0)
        {
            value <- NA
        }
    return(value)
            
            
    }
