### Mulit-Star 
### Star = 2
starCircle <- function(star, color, inner, outer, bias, lwd){
  #star <- 12
  innerRadius <- inner
  outerRadius <- outer
  #bias <- outer - inner
  iniAngle <- -pi/star
  
  innerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  outerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  
  ### Save innerPoints and outerPoints to Matrix
  for(k in 1:star){
    innerCircle[k, 1] <- bias*3 + innerRadius*cos( iniAngle + ((2*pi)/star)*k )
    innerCircle[k, 2] <- bias*0 + innerRadius*sin( iniAngle + ((2*pi)/star)*k )
    
    outerCircle[k, 1] <- bias*3 + outerRadius*cos( iniAngle + ((2*pi)/star)*k + pi/star )
    outerCircle[k, 2] <- bias*0 + outerRadius*sin( iniAngle + ((2*pi)/star)*k + pi/star )
  }
  
  ### Plot Star       
  #plot(0, xlim=c(-2,2), ylim=c(-2,2), type="n", xlab="", ylab="")
  for(k in 1:star){  
    segments(innerCircle[k,1], innerCircle[k,2], outerCircle[k,1], outerCircle[k,2], col=color, lwd=lwd)
    #arrows(innerCircle[k,1], innerCircle[k,2], outerCircle[k,1], outerCircle[k,2], col=color, length=0.1)
    #polygon(x=c(innerCircle[k,1], innerCircle[k,2]), y=c(outerCircle[k,1], outerCircle[k,2]), col=color)
    if(k < star){
      segments(outerCircle[k,1], outerCircle[k,2], innerCircle[k+1,1], innerCircle[k+1,2], col=color, lwd=lwd)
      #arrows(outerCircle[k,1], outerCircle[k,2], innerCircle[k+1,1], innerCircle[k+1,2], col=color, length=0.1)
      #polygon(x=c(innerCircle[k,1], innerCircle[k,2]), y=c(outerCircle[k+1,1], outerCircle[k+1,2]), col=color)
    }
    else{
      segments(outerCircle[star,1], outerCircle[star,2], innerCircle[1,1], innerCircle[1,2], col=color, lwd=lwd)
      #arrows(outerCircle[star,1], outerCircle[star,2], innerCircle[1,1], innerCircle[1,2], col=color, length=0.1)
      #polygon(x=c(innerCircle[star,1], outerCircle[star,1]), y=c(innerCircle[1,2], outerCircle[1,2]), col=color)
    }
  }  
}

