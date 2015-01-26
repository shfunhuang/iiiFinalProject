#從sql取得資料的function
def_data=function(){

library(rJava)
library(DBI)
library(RJDBC)
library(RSQLServer)
library("RODBC")

#drv = JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","C:/data/sqljdbc4-3.0.jar/sqljdbc4-3.0.jar")
#conn = dbConnect(drv,"jdbc:sqlserver://localhost:1433;databaseName=IMDB","sa","passw0rd")
conn <- odbcConnect("imdb", uid="BIGDATA-PC")

sqlText = paste('SELECT b.pkno, bo.weekendgross, b.weight_budget, c.weight_cast1_test, c.weight_cast2_test , c.weight_cast3_test, d.weight_director_test, g.weight_genres, m.weight_month, su.weight_superstar
                FROM weight_budget b , weight_cast_test c, weight_director_test d, weight_genres g, weight_month m, boxoffice bo, weight_superstar su
                WHERE b.pkno=c.pkno
                AND b.pkno=d.pkno
                AND b.pkno=g.pkno
                AND b.pkno=m.pkno
                AND b.pkno=bo.pkno
                AND b.pkno=su.pkno
                AND weekend=1
                ORDER BY weekendgross DESC')

#queryResults = dbGetQuery(conn,sqlText)
queryResults = sqlQuery(conn, sqlText)

#dbDisconnect(conn)
close(conn)

pkno=queryResults$pkno
gross=as.numeric(queryResults$weekendgross)
weight_budget=as.numeric(queryResults$weight_budget)
weight_cast1=as.numeric(queryResults$weight_cast1_test)
weight_cast2=as.numeric(queryResults$weight_cast2_test)
weight_cast3=as.numeric(queryResults$weight_cast3_test)
weight_director=as.numeric(queryResults$weight_director_test)
weight_genres=as.numeric(queryResults$weight_genres)
weight_month=as.numeric(queryResults$weight_month)
weight_superstar=as.numeric(queryResults$weight_superstar)

br1 = c(3746, 98899, 397473,  6463279, 11947745, 24968602, 207438709)
group=c()
for(j in 1:length(gross)){
  for(i in 1:6){
    if(gross[j]<=br1[i+1] & br1[i]<=gross[j]){
      group[j]=i
    }
  }  
}
data=data.frame(pkno,group,gross,weight_budget,weight_cast1,weight_cast2,weight_cast3,weight_director,weight_genres,weight_month,weight_superstar)
return(data)
}