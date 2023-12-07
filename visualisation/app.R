#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Factor vs. Score Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("factor", "Choose a factor to compare with score:",
                  choices = setdiff(colnames(data), c("Life.Ladder", "Country.name", "X", "year")))
    ),
    mainPanel(
      plotOutput("scorePlot")
    )
  )
)


server <- function(input, output) {

    output$scorePlot <- renderPlot({

          ggplot(data, aes_string(x = input$factor, y = "Life.Ladder")) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, color = "blue") + 
      labs(title = paste("Score vs.", input$factor),
           x = input$factor, y = "Score") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}


shinyApp(ui = ui, server = server)

