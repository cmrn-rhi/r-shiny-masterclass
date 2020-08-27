library(shiny)
library(DT)

ui <- fluidPage(

    # Application title
    titlePanel("Practising with data sources and processing - challenge"),

    fluidRow(
        column(4, 
               wellPanel(
                   
                   # Directions: How to use column filter input.
                   p("To remove a column, select it's header in the field below
                      and press 'backspace' or 'delete':"),
                   
                   # Ouput: Columns to display in table.
                   uiOutput("colSelection"),
                   
                   # Output: Column to apply filter to.
                   uiOutput("filterSelection"),
                   
                   # Output: Filter range selector.
                   uiOutput("filterRange")

               )
        ),
        column(8, 
               wellPanel(
                   # Table Output
                   DT::dataTableOutput("table_challenge"),
                   
                   # Download Link
                   downloadLink(outputId = "download", label = "Download CSV")
               )
        )
    )
)