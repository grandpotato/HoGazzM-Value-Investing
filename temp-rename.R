for(i in dir("extract/")){
    newname <- sub("([0-9][0-9])([0-9][0-9])([0-9][0-9])(.*)","extract/20\\1-\\2-\\3\\4",i)
    file.rename(paste("extract/",i,sep=""),newname)
}
#170506 060523 ZIM.txt