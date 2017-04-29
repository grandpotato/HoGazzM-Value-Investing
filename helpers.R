findCompanyHistoricals <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Company Historicals",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result][[1]]
}

findHistoricalFinancials <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Historical Financials",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result][[1]]
}

findBalanceSheet <- function(tables) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl("Balance Sheet",i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result][[1]]
}

getTable <- function(tables, targetTable) {
    #function returns index of the desired string identifying the table
    for(i in names(tables)) {
        if(grepl(targetTable,i)) {
            result <- which(names(tables) == i)
        }
        
    }
    tables[result][[1]]
}


record.new <-function() {
   a <-  data.frame("Company_Name" =character(0),
                      "Date" = character(0),
                      "Dividends" = numeric(0),
                      "Shares_Outstanding" = numeric(0),
                      "Revenues" = numeric(0),
                      "Income_Tax_Rate" = numeric(0),
                      "Net_Profit_Before_Abnormals" = numeric(0),
                      "Net_Profit" = numeric(0),
                      "Long_term_debt" = numeric(0),
                      "Shareholders_Equity" = numeric(0),
                      "EBITDA" = numeric(0),
                      "EBIT" = numeric(0),
                      "Total_Current_Assets" = numeric(0),
                      "Total_Current_Liabilities" = numeric(0)
   )
    
    
}