
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
teams <- read.csv("Teams.csv")
shinyServer(function(input, output, session) {

  output$winsPlot <- renderPlot({
    t <- teams[teams$year == as.character(input$season),]
    t$name <- factor(t$name, levels = t[order(t$W, decreasing = TRUE),]$name)
    
    p <- qplot(x = name, y = W, data = t) + ggtitle(paste(input$season," - ", input$season + 1, " Season Wins")) +
      xlab("Teams Ranked by # of Wins") + ylab("Wins") + theme(axis.text.x=element_text(angle=90, hjust=1, size = 12),
                                                               axis.title=element_text(size=14, face = "bold"),
                                                               plot.title=element_text(size=20, face = "bold"))
    print(p)
  })
  mwin <- reactive({
    t <- teams[teams$year == as.character(input$season),]
    mean(t$W)
  })
  
  output$avgWins <- renderText({
    paste("Average wins: ",round(mwin(),2))
  })
  
  mPts <- reactive({
    t <- teams[teams$year == as.character(input$season),]
    mean(t$Pts)
  })
  
  output$avgPts <- renderText({
    paste("Average points: ",round(mPts(),2))
  })
  
  mGF <- reactive({
    t <- teams[teams$year == as.character(input$season),]
    mean(t$GF)
  })
  
  output$avgGF <- renderText({
    paste("Average goals for: ",round(mGF(),2))
  })
  
  output$tbhead <- renderText({
    paste(input$tb," teams")
  })
  
  tb <- reactive({
    as.logical(ifelse(input$tb == "Top 5",1,0))
  })
  
  output$tb <- renderText({
    tb()
  })
  
  output$topbot <- renderTable({
    t <- teams[teams$year == as.character(input$season),]
    topbot <- head(t[order(t$W, decreasing = tb()),],5)
    topbot <- topbot[,-c(1,2,3,4,5,6,7,8,15,16,20,21,22,23,24,25,26,27)]

  })
})