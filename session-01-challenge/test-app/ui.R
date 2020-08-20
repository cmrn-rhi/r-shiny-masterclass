#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Sample Data"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            plotOutput("distPlot")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            sliderInput("bins",
                        "Bins Bins Bins!:",
                        min = 0,
                        max = 100,
                        value = 30)
        )
    )
))