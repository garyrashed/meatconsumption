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
library(stringr)

source("./global.R")


ui <- dashboardPage(
    dashboardHeader(
        title = "Meat consumption across the globe."),
        dashboardSidebar(
            sidebarUserPanel(
                name = 'Gary Rashed'
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
        fluidRow(
            selectInput(
                inputId = "countryName",
                label = strong("Country"),
                choices = unique(fullData$CountryName )
            ) ,
            selectInput(
                inputId = "measure",
                label = strong("Measure Type"),
                choices = unique(fullData$Measure )
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
        fluidRow(
            plotOutput("CountryConsumption")
        )
        #,
        # sidebarLayout(
        #     sidebarPanel(
        #         selectInput(
        #             inputId = "countryName",
        #             label = strong("Country"),
        #             choices = unique(fullData$CountryName )
        #         ) ,
        #         
        #         sliderInput(
        #             'dateRange',
        #             label = "Date",
        #             min = as.Date("1990", "%Y"),
        #             max = as.Date("2019", "%Y"),
        #             timeFormat = "%Y",
        #             value = c(as.Date("1990", "%Y"), as.Date("2019", "%Y"))
        #         )
        #     ),
        #     
        #     mainPanel(
        #         tabsetPanel(
        #             tabPanel("Map of Meat Consumption"),
        #             tabPanel("Country Breakdown."),
        #             tabPanel("Year over year breakdown.")
        #         ),
        #         plotOutput("CountryConsumption")
        #         
        #     )
        # )
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
        measure = input$measure
        print(startingDate)
        #endingDate = as.Date(format(input$dateRange[2], '%Y'))
        country = input$countryName
        
        countryData = fullData %>%  filter(., CountryName == country 
                                           & YearTime >= startingDate 
                                           & YearTime <= endingDate
                                           & Measure == input$measure)
 
        ggplot(countryData, aes(x = YearTime, y = MeatValue, group = Subj)) +
            geom_line(mapping = aes(color = Subj,stat = "identity", position = "identity")) +
            labs(title = str_interp("Country: ${country}. Years: ${startingDate} - ${endingDate}"),
                 x = "Year",
                 y = measure)
            #ggtitle(str_interp("Country: ${country}. Years: ${startingDate} - ${endingDate}"))
    })
}

# Run the application
shinyApp(ui = ui, server = server)
