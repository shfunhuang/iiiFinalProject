#���ͤ@�Ӧ^�k�ҫ�
regression_model=function(k1,k2,k3){
  source("def_data.r")
  
  data=def_data()
  data$gross=log(data$gross)
  train_data=data[which(data$group==k1 | data$group==k2 | data$group==k3),]
  
  lm=lm(gross~weight_budget+weight_cast1+weight_cast2+weight_cast3+weight_director+weight_genres+weight_month+weight_superstar,data=train_data)
  return(lm)
}
