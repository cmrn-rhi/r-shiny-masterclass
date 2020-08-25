library(shiny)

ui <- fluidPage(
  
  titlePanel("Pretty But Meaningless Patterns"),
  
  # Sidebar Layout.
  sidebarLayout(
    
    # Sidebar panel for inputs.
    sidebarPanel(
      
      # Break; extra vertical spacing.
      br(),
      
      # Input: 
      sliderInput('slider','Choose number:',min = 1, max = 20, value =10),
      sliderInput('slider2','Choose number:',min = 1, max = 80, value =40),
      checkboxInput('checkbox','Multiply by 10?')
      
    ),
    
    # Main panel for displaying outputs.
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", icon = icon("fas fa-chart-line"), plotOutput('plot')),
                  tabPanel("Table", icon = icon("table"), tableOutput("table")))
      
      
      
    )
    
  ))