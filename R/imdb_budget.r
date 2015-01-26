### Programming by Shfun Huang 2014.12.15
### Download: ODBC Driver 11 for SQL Server
rm(list=ls())
library("RODBC")
#source("./rcode/match.rate.r")
#rate <- read.csv("./data/HistER.csv", stringsAsFactors = F)

#################################################
### Loading Data from SQL Server: IMDB
#imdb <- odbcConnect("imdb", uid="SHFUNHUANG-PC")
imdb <- odbcConnect("imdb", uid="BIGDATA-PC")
#sqlSave(imdb, rate, rownames = F)

budget <- sqlQuery(imdb, 
'SELECT b.pkno, b.currency4b, b.budget, CONVERT(char(4), box.date) "date.year"
FROM budget b, boxoffice box, (SELECT b.pkno, sum(weekendgross) "TotalGross"
  						                 FROM boxoffice b
							                 GROUP by b.pkno, b.title
							                 HAVING sum(weekendgross) >= 300000) t 
WHERE b.pkno = box.pkno 
AND b.pkno = t.pkno
AND weekend = 1 
AND CONVERT(char(4),box.date) >= 2004
ORDER by currency4b, CONVERT(char(4),box.date)')

rate <- sqlQuery(imdb, 'SELECT * \
                        FROM histRate')

close(imdb)
#################################################
### Convert Historical Exchange Rate by Year
dim(budget) #1808 5
#str(budget)
head(budget)
table(budget$currency4b)
table(budget$date.year)

h.rate <- rate[1:14, -c(1,2)]
rownames(h.rate) <- rate$year[1:14]

e.rate <- matrix(, dim(budget)[1], 1)
for(i in 1:dim(budget)[1]){ 
  if(budget$date.year[i] != 2014){
    e.rate[i,1] <- h.rate[as.character(budget$date.year[i]), as.character(budget$currency4b[i])]  #budget$date.year & budget$currency4b
  }
  else{
    budget$date.year[i] = budget$date.year[i] - 1 # date.year=2014 replace by 2013
    e.rate[i,1] <- h.rate[as.character(budget$date.year[i]), as.character(budget$currency4b[i])]  #budget$date.year & budget$currency4b
  }
}

#which(is.na(rate[,1])) #date.year=2014 *106
e.rate <- 1/e.rate #¸É§¹¯Ê­È«á°õ¦æ
convert <- budget$budget * e.rate
convHistRateByYear <- cbind(budget[,c(1,2,4,3)], e.rate, convert)
head(convHistRateByYear)
#sqlSave(imdb, convHistRateByYear, rownames = F)




