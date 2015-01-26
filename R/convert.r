rm(list=ls())
library(xts)
source("./rcode/match.rate.r")
her <- read.csv("./data/HistER.csv", stringsAsFactors = F)
box <- read.csv("./data/bd.csv", stringsAsFactors = F)

table(box[,3])

box[,3]<- replace(box[,3], which(box[,3]=="$"), "USD.USD")
box[,3]<- replace(box[,3], which(box[,3]=="?"), "USD.GBP")
box[,3]<- replace(box[,3], which(box[,3]=="£á"), "USD.EUR")
box[,3]<- replace(box[,3], which(box[,3]=="AUD?"), "USD.AUD") 
box[,3]<- replace(box[,3], which(box[,3]=="BRL?"), "USD.BRL") 
box[,3]<- replace(box[,3], which(box[,3]=="CAD?"), "USD.CAD") 
box[,3]<- replace(box[,3], which(box[,3]=="CHF?"), "USD.CHF") 
box[,3]<- replace(box[,3], which(box[,3]=="CNY?"), "USD.CNY") 
box[,3]<- replace(box[,3], which(box[,3]=="CZK?"), "USD.CZK") 
box[,3]<- replace(box[,3], which(box[,3]=="DKK?"), "USD.DKK") 
box[,3]<- replace(box[,3], which(box[,3]=="ESP?"), "USD.ESP") 
box[,3]<- replace(box[,3], which(box[,3]=="FIM?"), "USD.FIM")
box[,3]<- replace(box[,3], which(box[,3]=="FRF?"), "USD.FRF")
box[,3]<- replace(box[,3], which(box[,3]=="HKD?"), "USD.HKD")
box[,3]<- replace(box[,3], which(box[,3]=="HUF?"), "USD.HUF")
box[,3]<- replace(box[,3], which(box[,3]=="INR?"), "USD.INR")
box[,3]<- replace(box[,3], which(box[,3]=="JPY?"), "USD.JPY")
box[,3]<- replace(box[,3], which(box[,3]=="KRW?"), "USD.KRW")
box[,3]<- replace(box[,3], which(box[,3]=="MXN?"), "USD.MXN")
box[,3]<- replace(box[,3], which(box[,3]=="NGN?"), "USD.NGN")
box[,3]<- replace(box[,3], which(box[,3]=="NOK?"), "USD.NOK")
box[,3]<- replace(box[,3], which(box[,3]=="NZD?"), "USD.NZD")
box[,3]<- replace(box[,3], which(box[,3]=="PLN?"), "USD.PLN")
box[,3]<- replace(box[,3], which(box[,3]=="SEK?"), "USD.SEK")
box[,3]<- replace(box[,3], which(box[,3]=="SGD?"), "USD.SGD")
box[,3]<- replace(box[,3], which(box[,3]=="THB?"), "USD.THB")
box[,3]<- replace(box[,3], which(box[,3]=="VEB?"), "USD.VEB")


### replace null*1780 to 0
for(i in 1:dim(box)[1]){
  box[,2][which(is.na(box[,2]))] <- 0
  box[,3][which(is.na(box[,3]))] <- 0  
}
table(box[,3])

### match the exchange rate
her <- her[1:14,]
str(her)
her.match <- her[,-c(1,2)]
rownames(her.match) <- her[,2]
box.rate <- match.rate(box)
#write.csv(box.rate, "./data/box.rate.csv")



