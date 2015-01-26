### Programming by Shfun Huang 2014.12.15
### Download: ODBC Driver 11 for SQL Server
rm(list=ls())
library("RODBC")

#################################################
### Loading Data from SQL Server: IMDB
#imdb <- odbcConnect("imdb", uid="SHFUNHUANG-PC")
imdb <- odbcConnect("imdb", uid="BIGDATA-PC")

box <- sqlQuery(imdb, 
'SELECT b.pkno, b.title, bd.budget, b.currency4wg, b.weekendgross, b.date, t.TotalGross
FROM boxoffice b, budget bd, (SELECT b.pkno, sum(weekendgross) as "TotalGross"
  						                FROM boxoffice b
							                GROUP by b.pkno, b.title
				                      HAVING sum(weekendgross) >= 300000) t
WHERE b.pkno = t.pkno 
AND b.pkno = bd.pkno
AND weekend = 1
AND CONVERT(char(4),b.date) >= 2004
ORDER by CONVERT(char(4),b.date)')
close(imdb)

#################################################
### Categorical by first weekend gross
dim(box) #1808 7
str(box)
head(box)
tail(box)
boxSortByWeekendGross <- box[order(box$weekendgross),]
str(boxSortByWeekendGross)
head(boxSortByWeekendGross)
tail(boxSortByWeekendGross)

breaks1 = c(0, 100000, 400000, 6500000, 12000000, 25000000, 207500000)
labels1 = seq(length(breaks1)-1)
table(cut(boxSortByWeekendGross$weekendgross, breaks=breaks1, labels=labels1))
# 181 209 395 274 400 349 
#barplot(table(cut(boxSortByWeekendGross$weekendgross, breaks=breaks1, labels=labels1)))
boxLevel <- cut(boxSortByWeekendGross$weekendgross, breaks=breaks1, labels=labels1)
boxLevelByWeekendGross <- cbind(boxSortByWeekendGross, boxLevel)
boxLevelSix <- boxLevelByWeekendGross
head(boxLevelSix)
#sqlSave(imdb, boxLevelSix[,c(1,2,3,4,5,7,8)], rownames = F)
#IMDB -> 工作 -> 產生指令碼 (進階)結構描述和資料
#close(imdb)

op1 <- par(mfrow=c(3,1))
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==1)], main = 1, horizontal=T)
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==2)], main = 2, horizontal=T)
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==3)], main = 3, horizontal=T)
par(op1)
op2 <- par(mfrow=c(3,1))
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==4)], main = 4, horizontal=T)
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==5)], main = 5, horizontal=T)
boxplot(boxLevelByWeekendGross$weekendgross[which(boxLevelByWeekendGross$boxLevel==6)], main = 6, horizontal=T)
par(op2)


