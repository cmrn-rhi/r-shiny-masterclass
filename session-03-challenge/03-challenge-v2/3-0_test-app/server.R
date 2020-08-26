
# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
    
    # Return the requested dataset.
    datasetInput <- reactive({
        switch(input$dataset,
               # "rock" = rock, # include all cols when selecting X/Y
               "rock" = rock[1:2],
               "pressure" = pressure,
               "cars" = cars)
    })
    
    # Combine the selected (x,y) variables into a new data frame.
    selectedData <- reactive({
        #datasetInput()[, c(input$xcol, input$ycol)] # for selecting X/Y
        datasetInput()
    })
    
    # Create caption, reactive to user input.
    output$caption <- renderText({
        input$caption
    })
    
    # Render scatter plot, reactive to user data selection.
    output$plot1 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
        
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
