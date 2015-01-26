# ui.R

shinyUI(fluidPage(
  titlePanel("StarCircleAnimation"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Opening weekend Gross Level Test"),           
      
      sliderInput("rating", 
                  label = "Number of star",
                  min = 1, max = 6, value = 1)
      ),
      
    mainPanel(
      textOutput("text1"),
      plotOutput("star", width = "400px", height="400px")
    )
  )
))

# server.R

source("./starCircle_ver4.r")

shinyServer(
  function(input, output) {
    #rating <- input$rating
    
    output$text1 <- renderText({ 
      paste("rating : ", input$rating)
    })

    output$star <- renderPlot({
      ### Multi-Star
      lim = 1
      starNum = 8
      range <- c(0.3, 0.5)
      step <- seq(-lim, lim, by=mean(range))
      
      plot(0, xlim=c(-length(step),length(step)), ylim=c(-length(step),length(step)), type="n", xlab="", ylab="", axe=F)
      # color: black
      for(k in 1:length(step)){
        starCircle(star=starNum, color="black", inner=range[1], outer=range[2], bias = step[k], lwd=1)
      }
      # color: red
      #rating = 3
      for(k in 1:input$rating){
        Sys.sleep(0.1)
        starCircle(star=starNum, color="red", inner=range[1], outer=range[2], bias = step[k], lwd=1.5)
        Sys.sleep(0.1)
      }     
      
    })
  }
)

# starCircle_ver4.r

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
    
    if(k < star){
      segments(outerCircle[k,1], outerCircle[k,2], innerCircle[k+1,1], innerCircle[k+1,2], col=color, lwd=lwd)
    }
    else{
      segments(outerCircle[star,1], outerCircle[star,2], innerCircle[1,1], innerCircle[1,2], col=color, lwd=lwd)
    }
  }  
}

