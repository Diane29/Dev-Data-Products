#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
setwd('C:/Users/Diane/Documents/DataProducts/birth')
birthdata <- read.csv("birthdata.csv",sep = ",")
birthdata <- birthdata[,c(1:56)]
realData <- rowSums(is.na(birthdata)) > 1
country <- birthdata[realData==FALSE,]
colnames(country) <- c("Country.Name", 1960:2014)
countries <- country[,1]

# Define server logic required to draw a histogram
shinyServer(function(input, output) 
  {
  cyFunc <- reactive({
    cData <- country[which(country$Country.Name == input$name),]
    cData <- melt(cData, id="Country.Name") 
    cData$variable <- as.character(cData$variable)
    cyData <- cData[cData$variable >= input$Years[1] & cData$variable <= input$Years[2],]
    cyData
  })
  
   output$myPlot <- renderPlot({
      pData <- cyFunc()
      #par(mfrow = c(2, 1))
      plot(pData$value ~ pData$variable, type="l", ylab = " Fertility Rate per Female", xlab = "Year",
      cex = 3.5, pch = 16, bty = "n", col= "red",
       main = paste("Fertility Rate in ", input$name[1], " from ", input$Years[1], " to ", input$Years[2])
          )
    })
      

})
