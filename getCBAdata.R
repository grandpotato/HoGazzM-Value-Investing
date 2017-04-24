#this is a group of functions ad scripts to get financial data out of CBA

loginCBA <- function(username, password){
    library(httr)
    library(XML)
    
    handle <- handle("https://www2.commsec.com.au") 
    path   <- "/Public/HomePage/Login.aspx"
    
    # fields found in the login form.
    login <- list(
        "__VIEWSTATE" = "/wEPDwUKMTQ2NTg5NTA1OQ9kFgJmD2QWAgIDD2QWAgIJD2QWAgIJD2QWBAIRD2QWBGYPFCsABA8WAh4HVmlzaWJsZWhkaGVoZAICDw8WBB4EVGV4dAUVSSBmb3Jnb3QgbXkgQ2xpZW50IElEHgtOYXZpZ2F0ZVVybAUnL1ByaXZhdGUvTXlQcm9maWxlL1Jlc2V0TXlQYXNzd29yZC5hc3B4FhIeE2RhdGEtbW9kYWwtY2FsbGJhY2sFHkNsaWVudENhbmNlbE1vZGFsRGlhbG9nQ29udHJvbB4RZGF0YS1tb2RhbC1oZWlnaHQFAzY4Mx4VZGF0YS1tb2RhbC13cmFwcGVyLWlkBVJjdGwwMF9jcENvbnRlbnRfbW9kYWxEaWFsb2dMaW5rRGV0YWlsc19tb2RhbERpYWxvZ0NvbnRyb2xfbW9kYWxEaWFsb2dJZnJhbWVXcmFwcGVyHhhkYXRhLWlmcmFtZS1jb250YWluZXItaWQFVGN0bDAwX2NwQ29udGVudF9tb2RhbERpYWxvZ0xpbmtEZXRhaWxzX21vZGFsRGlhbG9nQ29udHJvbF9pZnJhbWVNb2RhbERpYWxvZ0NvbnRhaW5lch4FY2xhc3MFEG9wZW5Nb2RhbERpYWxvZyAeB29uY2xpY2sFDXJldHVybiBmYWxzZTseEGRhdGEtbW9kYWwtdGl0bGUFG0NyZWF0ZSBhIE5ldyBMb2dpbiBQYXNzd29yZB4QZGF0YS1tb2RhbC13aWR0aAUDNjAwHhdkYXRhLW1vZGFsLWNvbnRhaW5lci1pZAVIY3RsMDBfY3BDb250ZW50X21vZGFsRGlhbG9nTGlua0RldGFpbHNfbW9kYWxEaWFsb2dDb250cm9sX3BubE1vZGFsRGlhbG9nZAITD2QWBGYPFCsABA8WAh8AaGRoZWhkAgIPDxYEHwEFFEkgZm9yZ290IG15IHBhc3N3b3JkHwIFJy9Qcml2YXRlL015UHJvZmlsZS9SZXNldE15UGFzc3dvcmQuYXNweBYSHwMFHkNsaWVudENhbmNlbE1vZGFsRGlhbG9nQ29udHJvbB8EBQM2ODMfBQVTY3RsMDBfY3BDb250ZW50X21vZGFsRGlhbG9nTGlua1Bhc3N3b3JkX21vZGFsRGlhbG9nQ29udHJvbF9tb2RhbERpYWxvZ0lmcmFtZVdyYXBwZXIfBgVVY3RsMDBfY3BDb250ZW50X21vZGFsRGlhbG9nTGlua1Bhc3N3b3JkX21vZGFsRGlhbG9nQ29udHJvbF9pZnJhbWVNb2RhbERpYWxvZ0NvbnRhaW5lch8HBRBvcGVuTW9kYWxEaWFsb2cgHwgFDXJldHVybiBmYWxzZTsfCQUbQ3JlYXRlIGEgTmV3IExvZ2luIFBhc3N3b3JkHwoFAzYwMB8LBUljdGwwMF9jcENvbnRlbnRfbW9kYWxEaWFsb2dMaW5rUGFzc3dvcmRfbW9kYWxEaWFsb2dDb250cm9sX3BubE1vZGFsRGlhbG9nZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WAQUYY3RsMDAkY3BDb250ZW50JGNrU2F2ZUlExCk4z6QJ5v/jE/27PHQGs/XeDOZ+g047n9CxxiiOocM="
        ,"__VIEWSTATEGENERATOR" = "EBE86427"
        ,"__EVENTTARGET" = ""
        ,"ctl00$cpContent$txtLogin" = username
        ,"ctl00$cpContent$fakepassword" = password
        ,"ctl00$cpContent$btnLogin"= "Login"
    )
    
    #Are my field attributes correct? Am I using POST correctly? Am I viewing the contents that I'm beign returned correctly?
    #Validate each one.
    
    POST(handle = handle, path = path, body = login)
    
}
    
    