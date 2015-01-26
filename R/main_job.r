source("def_data.r")
source("randomforest.r")
source("regression_model.r")

data=def_data()
#���odata
index=sample(c(1,2),dim(data)[1],c(0.8,0.2),replace=T)
train_data=data[which(index==1),]
test_data=data[which(index==2),]
#�H����� train_data �M test_data
classifier=def_randomForest(20141229,train_data,test_data)
ba_tree=classifier$batree
#�إߤ����ҫ�
class=classifier[[1]]
#��test_data �Q������@��
lm1=regression_model(0,1,2)
lm2=regression_model(1,2,3)
lm3=regression_model(2,3,4)
lm4=regression_model(3,4,5)
lm5=regression_model(4,5,6)
lm6=regression_model(5,6,0)
model=list(lm1,lm2,lm3,lm4,lm5,lm6)
#�C�Ӱ϶����O�إ߹w���ҫ�
fit = vector(length=dim(test_data)[1])
lwr = vector(length=dim(test_data)[1])
upr = vector(length=dim(test_data)[1])
conclusion=data.frame(test_data[,c(1,2)],class,log(test_data[,3]),fit,lwr,upr)
#�إ߭ө񵲪G���a��
for(i in 1:dim(test_data)[1]){
  pred=predict(model[[class[i]]],newdata=test_data[i,4:11],interval="prediction", level = 0.9)
  conclusion[i,5]=pred[1]
  conclusion[i,6]=pred[2]
  conclusion[i,7]=pred[3]
}
#�̷Ӥ������G��i���Ӱ϶����w���ҫ� �N�w�����G �M�w���϶����W�U��

lm=lm(log(gross)~weight_budget+weight_cast1+weight_cast2+weight_cast3+weight_director+weight_genres+weight_month+weight_superstar,data=train_data)
pred=predict(lm,newdata=test_data[,4:11],interval="prediction", level = 0.9)
conclusion2=data.frame(test_data[,c(1,2)],class,log(test_data[,3]),pred)
#�������������j�k�ҫ��w�����G

co=0
for(i in 1:dim(test_data)[1]){
  if( conclusion[i,4]<= conclusion[i,7] & conclusion[i,4]>=conclusion[i,6]) co=co+1  
}
co/dim(test_data)[1]
#�����w�����ǽT�v
co2=0
for(i in 1:dim(test_data)[1]){
  if( conclusion2[i,4]<= conclusion2[i,7] & conclusion2[i,4]>=conclusion2[i,6]) co2=co2+1  
}
co2/dim(test_data)[1]
#�������w�����ǽT�v


