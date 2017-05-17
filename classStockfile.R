stockFile <- setClass("StockFile",
         slots = c(
             stockcode = "character",
             fileLocation = "character"
         ),
         prototype = c("ZZZ","empty"),
         validity = function(object)
         {
             if(length(object@stockcode)<3)
             {
                 print("This stockcode is too short")
             }
             return(TRUE)
         }
         )

setGeneric(name = "readFileToHTML",
           def = function(object) 
               {
                    standardGeneric("readFiletoHTML")
               }
           )
# Create a class to handles the file connections and return the tables, and also writes files
# make a class to read the tables
# make a destination data structure class, include export function
#