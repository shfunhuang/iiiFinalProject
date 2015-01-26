### Programming by Shfun Huang 2014.12.28
### Download: ODBC Driver 11 for SQL Server
rm(list=ls())
library("RODBC")
library("psych")
#source("./rcode/match.rate.r")
#rate <- read.csv("./data/HistER.csv", stringsAsFactors = F)

#################################################
### Loading Data from SQL Server: IMDB
imdb <- odbcConnect("imdb", uid="SHFUNHUANG-PC")
#imdb <- odbcConnect("imdb", uid="BIGDATA-PC")
feature <- sqlQuery(imdb, 
'SELECT b.pkno, b.weight_budget, c.weight_cast1_test, c.weight_cast2_test , c.weight_cast3_test, d.weight_director_test, g.weight_genres, m.weight_month
FROM weight_budget b , weight_cast_test c, weight_director_test d, weight_genres g, weight_month m
WHERE b.pkno=c.pkno
AND b.pkno=d.pkno
AND b.pkno=g.pkno
AND b.pkno=m.pkno')
close(imdb)

#################################################
### PCA
dim(feature) #1808 8
str(feature)
head(feature)

feature.pr <- princomp(~weight_budget+weight_cast1_test+weight_cast2_test+weight_cast3_test+weight_director_test+weight_genres+weight_month, data=feature,cor=F)
colnames(feature[,-c(1)])
summary(feature.pr, loadings=T)

feature.pred <- predict(feature.pr)
dim(feature.pred) #1808 7

screeplot(feature.pr)
#biplot(feature.pr)

