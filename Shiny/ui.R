
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("NHL Team Statistics"),

  # Sidebar with drop down for team and slider for year
  sidebarLayout(
    sidebarPanel(
      sliderInput("season",
                  "Use the slider to choose a year:",
                  min = 1909,
                  max = 2015,
                  value = 2015,
                  sep = ""),
      radioButtons("tb", "Choose whether to show Top 5 or Bottom 5 teams for the year", choices = c("Top 5", "Bottom 5"), selected = "Top 5"),
      textOutput("avgWins"),
      textOutput("avgPts"),
      textOutput("avgGF"),
      textOutput(""),
      textOutput(""),
      h3("Documentation:"),
      h4("This app contains data for all NHL seasons from 1909 to 2015. Use the slider to select a year to filter the data by season 
          and the radio button to select whether to show the top 5 or bottom 5 teams from that season")
    ),

  # Show a plot of the information selected and either top 5 or bottom 5 teams based on radio button selection
    mainPanel(
      plotOutput("winsPlot"),
      textOutput("tbhead"),
      tableOutput("topbot")
    )
  )
))
