library(ggplot2)


con=data.frame(c(1:dim(test_data)[1]),conclusion,conclusion2[,6:7])
names(con)[1]="no"
names(con)[5]="log"
con=con[1:150,]
se=ggplot(con, aes(x=no, y=log)li) + geom_line(size=.8)
se2=se+geom_line(aes(y=lwr), colour="red")+geom_line(aes(y=upr), colour="red")
se3=se2+geom_line(aes(y=lwr.1), colour="blue", linetype="dotted")+geom_line(aes(y=upr.1), colour="blue", linetype="dotted")

se3
#�¦⪺��ڭ� ���⪺�u�O�����w�����w���϶� �Ŧ⪺�O���������w���϶�