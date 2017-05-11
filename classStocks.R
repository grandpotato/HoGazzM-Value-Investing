getStockCodes <- function(stockrange = NA){
    #This function returns a list of stockcodes from the specified CSV.
    #stockrange can be specified if you wish to subset the stocks.
    #Useful if you know you've already processed a certain number of files
    
    conn <- file("data/20170201-all-ords.csv","r")
    
    if(is.na(stockrange)) {
        result <- read.csv(conn, header = TRUE, skip = 1 )[[1]]
    } else {
        result <- read.csv(conn, header = TRUE, skip = 1 )[[1]][stockrange]
    }
    close(conn)
    result
}
    