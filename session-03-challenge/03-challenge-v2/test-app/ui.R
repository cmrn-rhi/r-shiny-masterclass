
library(shiny)

# Dataset variables
rock_vars <- setdiff(names(rock), "rocks")
pressure_vars <- setdiff(names(pressure), "pressures")
cars_vars <- setdiff(names(cars), "carss")

# Define UI for dataset viewer app ----
ui <- fluidPage(
    
    # App title.
    titlePanel("Hello Data"),
    
    # Sidebar layout.
    sidebarLayout(
        
        # Sidebar panel for inputs.
        sidebarPanel(
            
            # Input: Text for providing a caption.
            textInput(inputId = "caption",
                      label = "Caption:",
                      value = "Caption"),
            
            # Input: Selector for choosing dataset.
            selectInput(inputId = "dataset",
                        label = "Choose a dataset:",
                        choices = c("rock", "pressure", "cars")),
            
            # Attempt at having conditional X/Y axis options via hidden
            # pannels. Could not get to work with more than on dataset
            # at a time.

            # # Input: Rock dataset X variable selection for plot.
            # conditionalPanel(
            #     condition = "input.dataset == 'rock'",
            #     selectInput("xcol",
            #                 "Rock X Variable",
            #                 rock_vars),
            # ),
            # 
            # # Input: Rock dataset Y variable selection for plot.
            # conditionalPanel(
            #     condition = "input.dataset == 'rock'",
            #     selectInput("ycol",
            #                 "Rock Y Variable",
            #                 rock_vars, selected = rock_vars[[2]]),
            # ),
            

            # #Input: Selector for plot X variable.
            # selectInput("xcol",
            #             "X Variable",
            #             pressure_vars),
            # 
            # #Input: Selector for plot Y variable.
            # selectInput("ycol",
            #             "Y Variable",
            #             pressure_vars, selected = pressure_vars[[2]]),
            
            
            # Input: Numeric entry for number of obs to view.
            numericInput(inputId = "obs",
                         label = "Number of observations to view:",
                         value = 10)
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            tabsetPanel(type = "tabs", 
                        
            # Output: Formatted text for caption ----
            tabPanel("Plot",
                     icon = icon("fas fa-chart-line"),
                     h3(textOutput("caption", container = span)),
                     plotOutput('plot1')),
       
            # Output: HTML table with requested number of observations ----
            tabPanel("Observations Table",
                     icon = icon("table"),
                     tableOutput("view")),
            
            # Output: Verbatim text for data summary ----
            tabPanel("Summary",
                     icon = icon("fas fa-align-justify"),
                     verbatimTextOutput("summary"))
            
            )
        )
    )
)

