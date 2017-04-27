findCompanyHistoricals <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Company Historicals",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result]
}

findHistoricalFinancials <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Historical Financials",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result]
}

findBalanceSheet <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Balance Sheet",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result]
}

getTable <- function(tables, targetTable) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl(targetTable,i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result]
}


record.new <-function() {
   a <-  data.frame(row.names = c("Company_Name",
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
                                  "Total_Current Liabilities"
   ))
    
    
}