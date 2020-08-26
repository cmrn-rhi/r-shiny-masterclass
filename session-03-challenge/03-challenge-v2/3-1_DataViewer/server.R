# -------------------------------------
# DataViewer
# Challenge.Version: 3.1
# Date: 2020/08/25
# RStudio Server Pro Version 1.3.1056-1
# @author: Rhiannon Cameron
#         orcid.org/0000-0002-9578-0788
# -------------------------------------

# Dataset variables
rock_vars <- setdiff(names(rock), "rock_on")
pressure_vars <- setdiff(names(pressure), "pressure_on")
cars_vars <- setdiff(names(cars), "cars_on")


# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
    
    
    # Return the requested dataset.
    datasetInput <- reactive({
        switch(input$dataset,
               # "rock" = rock, # include all cols when selecting X/Y
               "rock" = rock,
               "pressure" = pressure,
               "cars" = cars)
    })
    
    
    # Generate X axis variable list
    output$xColContainer <- renderUI({
        
        # Triggers and error if input data contains unacceptable input.
        req(input$dataset)
        
        # Define X variable inputs based on user selected dataset.
        xOptions <- c()
        if(input$dataset == "rock"){
            xOptions <- rock_vars
        }else if(input$dataset == "pressure"){
            xOptions <- pressure_vars
        }else if(input$dataset == "cars"){
            xOptions <- cars_vars
        }
        
        # Input: dataset X variable selection for plot.
        selectInput("xcol",
                    "X Variable",
                    xOptions, selected = xOptions[[1]])
    })
    
    
    # Generate Y axis variable list
    output$yColContainer <- renderUI({
        
        # Triggers and error if input data contains unacceptable input.
        req(input$dataset)
        
        # Define Y variable input based on user selected dataset.
        yOptions <- c()
        if(input$dataset == "rock"){
            yOptions <- rock_vars
        }else if(input$dataset == "pressure"){
            yOptions <- pressure_vars
        }else if(input$dataset == "cars"){
            yOptions <- cars_vars
        }
        
        # Input: dataset Y variable selection for plot.
        selectInput("ycol",
                    "Y Variable",
                    yOptions, selected = yOptions[[2]])
    })
    
    
    # Combine the selected (x,y) variables into a new data frame.
    selectedData <- reactive({
        datasetInput()[, c(input$xcol, input$ycol)] # for selecting X/Y
    })
    
    
    # Create caption, reactive to user input.
    output$caption <- renderText({
        input$caption
    })
    
    
    # Render scatter plot, reactive to user data selection.
    output$plot1 <- renderPlot({
        par(mar = c(5.1, 4.1, 1, 2.1))
        plot(selectedData(),
             pch = 20, cex = 3, col = "darkblue")
    })
    
    
    # Generate a summary of the dataset, reactive to user data selection.
    output$summary <- renderPrint({
        dataset <- datasetInput()
        summary(dataset)
    })
    
    
    # Show the first "n" observations, reactive to user input.
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
    
}
