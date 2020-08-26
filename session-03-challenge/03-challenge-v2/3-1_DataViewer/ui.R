# -------------------------------------
# DataViewer
# Challenge.Version: 3.1
# Date: 2020/08/25
# RStudio Server Pro Version 1.3.1056-1
# @author: Rhiannon Cameron
#         orcid.org/0000-0002-9578-0788
# -------------------------------------

library(shiny)


# Define UI for DataViewer app ----
ui <- fluidPage(
    
    # App title.
    titlePanel("Super Special DataViewer"),
    
    # Sidebar layout.
    sidebarLayout(
        
        # Sidebar panel for inputs.
        sidebarPanel(
            
            # Input: Text for providing a plot caption.
            textInput(inputId = "caption",
                      label = "",
                      value = "Enter Title"),
            
            br(),
            
            # Input: Selector for choosing a dataset.
            selectInput(inputId = "dataset",
                        label = "Choose a dataset:",
                        choices = c("rock", "pressure", "cars")),
            
            # Input: Select X-axis from dataset options.
            uiOutput("xColContainer"),
            
            # Input: Select Y-axis from dataset options.
            uiOutput("yColContainer"),
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Hide error messages in UI (still present in log)
            # Implemented to hide "Warning: Error in pairs.default: only one 
            # column in the argument to 'pairs'" which briefly occurs while
            # the plot is rendering.
            tags$style(type="text/css",
                       ".shiny-output-error { visibility: hidden; }",
                       ".shiny-output-error:before { visibility: hidden; }"
            ),
            
            tabsetPanel(type = "tabs", 
                        
                        # Output: Formatted text for caption.
                        tabPanel("Plot",
                                 icon = icon("fas fa-chart-line"),
                                 h3(textOutput("caption", container = span)),
                                 plotOutput('plot1')),
                        
                        # Output: HTML table with requested number of observations.
                        tabPanel("Observations Table",
                                 icon = icon("table"),
                                 # Input: Numeric entry for number of rows to view.
                                 numericInput(inputId = "obs",
                                              label = h3("Number of observations:"),
                                              value = 10),
                                 tableOutput("view")),
                        
                        # Output: Verbatim text for data summary.
                        tabPanel("Summary",
                                 icon = icon("fas fa-align-justify"),
                                 h3("Summary"),
                                 verbatimTextOutput("summary"))
                        
            )
        )
    )
)

