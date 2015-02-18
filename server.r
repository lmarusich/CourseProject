library(shiny)

shinyServer(
  function(input,output){
    clicks <- 0
    yrange <- c(0,0.4)
    xrange <- c(-4,4)
    
    output$myDist <- renderPlot({
      mu <- as.numeric(input$popmu)
      sig <- as.numeric(input$popsig)
      x <<- seq(-4*sig+mu,4*sig+mu,length=500)
      y <- 1/(sig * sqrt(2*pi))*exp(-(x-mu)^2/(2*sig^2))
      
      if (input$axisbutton > clicks){
        clicks <<- input$axisbutton
        xrange <<- range(x)
        yrange <<- range(y)
      }
      
      plot(x,y,type="l",lwd=2,col='blue',ylab="Probability Density",xlab="",
           xlim = xrange, ylim=yrange,main="Population Distribution")
      
      text(mu,yrange[2]*.5,cex=1.75,bquote(mu==.(mu)))
      text(mu,yrange[2]*.4,cex=1.75,bquote(sigma==.(sig)))
    })
    
    output$sampleMeans <- renderPlot({
      
      input$samplebutton
      if (input$samplebutton==0){
        return()
      }
      samplemeans <- numeric(1000)
      isolate(ss <- as.numeric(input$ss))
      isolate(mu <- as.numeric(input$popmu))
      isolate(sig <- as.numeric(input$popsig))
      for (i in 1:1000){
        samplemeans[i] <- mean(rnorm(ss,mean=mu,sd=sig))
      }
      
      hist(samplemeans,xlim=xrange,main="1000 Sample Means")
      pred <- sig/sqrt(ss)
      actual <- sd(samplemeans)
      
      text(quantile(x,probs=.30),100,cex=1.75,bquote(over(sigma,sqrt(n))==.(round(pred,3))),adj=1)
      text(quantile(x,probs=.30),60,cex=1.75,bquote(SE(bar(x))==.(round(actual,3))),adj=1)
    })
  }
)



#     x <- reactive({as.numeric(input$text1)+100})
#     output$text1 <- renderText({input$text1})
#     output$text2 <- renderText({input$text2})
#     output$text3 <- renderText({
#       if (input$goButton == 0) "You have not pressed the button"
#       else if (input$goButton == 1) "you pressed it once"
#       else "Ok quit pressing it"
# #       isolate(paste(input$text1, input$text2))
#     })
#   }
# )
#     

#     output$newHist <- renderPlot({
#       hist(galton$child,xlab='child height',col='lightblue',main='Histogram')
#       mu <- input$mu
#       lines(c(mu,mu),c(0,200),col='red',lwd=5)
#       mse <- mean((galton$child - mu)^2)
#       text(63,150,paste("mu= ",mu))
#       text(63,140,paste("MSE = ",round(mse,2)))
#     })
#     

#     output$inputValue <- renderPrint({input$glucose})
#     output$prediction <- renderPrint({diabetesRisk(input$glucose)})
#     

#     output$oid1 <- renderPrint({input$id1})
#     output$oid2 <- renderPrint({input$id2})
#     output$odate <- renderPrint({input$date})
#   }
# )