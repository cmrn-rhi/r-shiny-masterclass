library(DT)
library(readr)
library(dplyr)
library(gapminder)

server <- function(input, output) {
    
    # Set working directory
    setwd("/cloud/project/challenge")
    
    # Generate column options.
    output$colSelection <- renderUI({
        
        # Triggers an error if input data contains unacceptable input.
        req(csv_data)
        
        # Input: select column headers to observe.
        selectInput("col",
                    "Column Selection:",
                    colOptions,
                    multiple = TRUE,
                    selected = colOptions)
    })
    
    # Filter selection. 
    output$filterSelection <- renderUI({

        # Input: Selector for choosing column to apply filters to.
        selectInput("select", "Apply Filter To:", 
                    choices = input$col, 
                    selected = input$col[1])
    })
    
    # Input: filter range when column containing numerics is selected
    output$filterRange <- renderUI({
        
        # Logical value for filter selection.
        test <- unlist(lapply(csv_data, is.numeric))[input$select]
        
        # Output numeric slider if TRUE. 
        if (test){
            
            sliderInput("range", 
                        "Filter Range:", 
                        min = min(csv_data[, c(input$select)]),
                        max = max(csv_data[, c(input$select)]), 
                        value = c(min(csv_data[, c(input$select)]),
                                  max(csv_data[, c(input$select)])))
        # Attempt to prevent "Warning: Error in if: missing value where 
        # TRUE/FALSE needed"
        } else if (is.na(test)){
            
            return()
        }
    })

    # Apply column header selection and range filters (when applicable).
    dataSelection <- reactive({
        
        # Update data frame to only include user selected columns.
        csv_data <- subset(csv_data, select = input$col)
        
        # Logical value for filter selection.
        test <- unlist(lapply(csv_data, is.numeric))[input$select]
        
        # Apply filter if numeric data.
        if (test){
            
            # Filter between user selected minimum and maximum.
            csv_data <- filter(csv_data,
                               csv_data[input$select] > input$range[1] &   # min
                               csv_data[input$select] < input$range[2])    # max
        } else{
            csv_data
        } 

    })
    
    # Render table.
    output$table_challenge <- DT::renderDataTable({
        datatable(dataSelection(), # replace with your data
                  options = list(scrollX = TRUE)
                  )
    })
}