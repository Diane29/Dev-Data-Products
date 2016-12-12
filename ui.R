#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(reshape)
library(shiny)
library(ggplot2)

birthdata <- read.csv("birthdata.csv",sep = ",")
birthdata <- birthdata[,c(1:56)]
realData <- rowSums(is.na(birthdata)) > 1
country <- birthdata[realData==FALSE,]
colnames(country) <- c("Country.Name", 1960:2014)
countries <- country[,1]


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
    # Application title
  titlePanel(h1("Fertility Rates around the World")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("name", 
                  label = "Choose Country",
                  choices = countries[],
                  selected = countries[1]),
      
      sliderInput("Years", 
                  label = "Select Years",
                  min = 1960, max = 2014, value = c(1978, 2010), step=1, sep="")
      ), 
     # Show a plot of the generated distribution
    mainPanel(
      
      plotOutput("myPlot")
    )
  )
))

