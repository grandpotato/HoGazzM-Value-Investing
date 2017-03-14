#this is a group of functions ad scripts to get financial data out of CBA

loginCBA <- function(username, password){
    library(httr)
    library(XML)
    source("../Temp/temp.R")
    
    handle <- handle("https://www.comsec.com.au") 
    path   <- ""
    
    # fields found in the login form.
    login <- list(
        "UcHeader1$LoginName" = LoginName
        ,"UcHeader1$Password" = Password
        ,"UcHeader1$StartIn" = ""
        ,"UcHeader1$ibtnGo.x" = "0"
        ,"UcHeader1$ibtnGo.y" = "0"
        ,"__EVENTARGUMENT" = ""
        ,"__EVENTTARGET" = ""
        ,"__EVENTVALIDATION" = "/wEWHwKYsoGKCgKmz++DBwKt88GwAwL55v+TAwLw5p3NAQKMmc7MAQKMmdbMAQKImarNAQL75tnMAQLty4bQDgKVnub8DAL9h4GIDwKZy43aBwLxqsB3ArmJgtgGAr7TvYACAuKGlc4IAp6ap4cNAqf4vqULApTe1dUFAuaRtbsPAqqlq/ANAo2f93ACk97llQcCo4Tn4wsC/dWLgQQClY6brwEClY6brwECwvSc1Q8ClY6brwEClY6brwHtz8pXw/EpS8BIdhfUbex02R5B7g=="
        ,"__PREVIOUSPAGE" = "4oc-N7Xk4plPRZBxTLYtOwwwzNwUH65FazIzceSK3sdmI5G6FR95JbkkzRIfqUJq4SydZU5hUaKJiRx9zQBDXY4xnAs1"
        ,"__VIEWSTATE" = "/wEPDwUKMTg0OTY5NDc3OWQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFEFVjSGVhZGVyMSRpYnRuR2/ivQSBGO8F7WNQwLqwJfX+Jwk/oQ=="
        ,"__EVENTTARGET" = ""
        ,"ddlApplyFor" = "Select"
        ,"ddlOtherSites" = "More quick links"
        ,"txt-clientId" = "51484768"
        ,"password-field" = "Kuami8acco"
    )
    
    #Are my field attributes correct? Am I using POST correctly? Am I viewing the contents that I'm beign returned correctly?
    #Validate each one.
    
    response <- POST(handle = handle, path = path, body = login)
    
    #write the output to file
    fileConn <- file("output.htm")
    writeLines(content(response,"text"),fileConn)
    close(fileConn)
}
    
    