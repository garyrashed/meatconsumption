#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(leaflet)
library(shinydashboard)

source("./global.R")


# Define UI for application that draws a histogram
ui <- fluidPage(


    # Application title
    titlePanel("Meat Consumption over 1990 - 2019."),
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "countryId",
                        label = strong("Country"),
                        choices = unique(fullData$Country)),

            sliderInput('dateRange', label = "Date", min = as.Date("1990", "%Y"), max = as.Date("2019", "%Y"),
                        timeFormat = "%Y", value = c(as.Date("1990", "%Y"), as.Date("2019", "%Y")))
            ),
        
        mainPanel(
            tabsetPanel(
                 tabPanel("Map of Meat Consumption"),
                 tabPanel("Country Breakdown."),
                 tabPanel("Year over year breakdown.")
            )
        )    
    )


        # sidebarlayout(
        #     sidebarpanel(
        #     #     sliderinput("bins",
        #     #                 a"number of bins:",
        #     #                 min = 1,
        #     #                 max = 50,
        #     #                 value = 30)
        #      )
        #     ),
   

    
)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application 
shinyApp(ui = ui, server = server)
