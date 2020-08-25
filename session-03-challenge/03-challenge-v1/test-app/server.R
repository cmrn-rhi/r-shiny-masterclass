

server <- function(input, output) {

  # Prepare input data for plot output.
  toPlot <- reactive({

    # Generate X and Y arrays from input sliders.
    test <- array(runif(input$slider, min = 0, max = 20), input$slider2)

  })

  # Generate dataframe consisting of manipulated input data.
  noGoodTable <- reactive({
    
    moreColumns <- data.frame("X_Data" = (toPlot()),
                              "X2_Data" = toPlot() * 2,
                              "Xtra_Data" = toPlot() * runif (1, 3, 100),
                              "Xtraordinary" = toPlot() * toPlot())
    return(moreColumns)
    
  })
  
  # Generate a meaningless plot from user input data.
  output$plot <- renderPlot(plot(toPlot()))
  
  # Generate meaningless table from user input data.
  output$table <- renderTable(noGoodTable())

  
}

