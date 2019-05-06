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
library(ggplot2)
library(leaflet)
library(shinydashboard)

source("./global.R")


ui <- dashboardPage(
    dashboardHeader(
        title = "Meat consumption across the globe."),
        dashboardSidebar(
            sidebarUserPanel(
                name = 'Gary Rashed',
                image = 'MEDIUM.png'
            ),
            sidebarMenu(
                menuItem(
                    "Dashboard",
                    tabName = "dashboard",
                    icon = icon("dashboard")
                ),
                menuItem("Widgets", tabName = "widgets",
                         icon = icon("th"))
            )
        ),
    dashboardBody(fluidPage(
        titlePanel("Meat Consumption over 1990 - 2019."),
        sidebarLayout(
            sidebarPanel(
                selectInput(
                    inputId = "countryName",
                    label = strong("Country"),
                    choices = unique(fullData$CountryName )
                ) ,
                
                sliderInput(
                    'dateRange',
                    label = "Date",
                    min = as.Date("1990", "%Y"),
                    max = as.Date("2019", "%Y"),
                    timeFormat = "%Y",
                    value = c(as.Date("1990", "%Y"), as.Date("2019", "%Y"))
                )
            ),
            
            mainPanel(
                tabsetPanel(
                    tabPanel("Map of Meat Consumption"),
                    tabPanel("Country Breakdown."),
                    tabPanel("Year over year breakdown.")
                ),
                plotOutput("CountryConsumption")
                
            )
        )
    )
    )
)


# # # Define UI for application that draws a histogram
# ui <- fluidPage(
#
#
#     # Application title
#     titlePanel("Meat Consumption over 1990 - 2019."),
#     sidebarLayout(
#         sidebarPanel(
#             selectInput(inputId = "countryId",
#                         label = strong("Country"),
#                         choices = unique(fullData$Country)),
#
#             sliderInput('dateRange', label = "Date", min = as.Date("1990", "%Y"), max = as.Date("2019", "%Y"),
#                         timeFormat = "%Y", value = c(as.Date("1990", "%Y"), as.Date("2019", "%Y")))
#             ),
#
#         mainPanel(
#             tabsetPanel(
#                  tabPanel("Map of Meat Consumption"),
#                  tabPanel("Country Breakdown."),
#                  tabPanel("Year over year breakdown.")
#             )
#         )
#     )
#
#
#         # sidebarlayout(
#         #     sidebarpanel(
#         #     #     sliderinput("bins",
#         #     #                 a"number of bins:",
#         #     #                 min = 1,
#         #     #                 max = 50,
#         #     #                 value = 30)
#         #      )
#         #     ),
#
#
#
# )

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    output$CountryConsumption<-renderPlot({
        startingDate = as.integer(format(input$dateRange[1], '%Y'))
        endingDate = as.integer(format(input$dateRange[2], '%Y'))
        print(startingDate)
        #endingDate = as.Date(format(input$dateRange[2], '%Y'))
        country = input$countryName
        
        countryData = fullData %>%  filter(., CountryName == country & YearTime >= startingDate & YearTime <= endingDate)
 
        ggplot(countryData, aes(x = YearTime, y = MeatValue)) +
            geom_point(mapping = aes(color = Subj)) +
            ggtitle("adfa")
    })
}

# Run the application
shinyApp(ui = ui, server = server)
