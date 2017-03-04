library(shiny)
Core <- read.csv("Core.csv", stringsAsFactors = FALSE)
ui <- fluidPage(
  titlePanel("My Nonprofit IRS Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("gross_receiptsInput", "Gross Receipts", 0, 1000000, c(50000, 75000), pre = "$"),
      radioButtons("typeInput", "Form type",
                  choices = c("990", "990 EZ"),
                  selected = "990"),
      selectInput("fisyrInput", "Fiscal Year",
                  choices = c("2010", "2011", "2012"))
    ),
    mainPanel("the results will go here")
  )
)
server <- function(input, output) {
output$coolplot <- renderPlot({
    filtered <-
      bcl %>%
      filter(Gross Receipts >= input$gross_receiptsInput[1],
             Gross Receipts <= input$priceInput[2],
             Type == input$typeInput,
             Fiscal Year == input$fisyrInput
      )
    ggplot(filtered, aes(TOTVOLUNTEERS)) +
      geom_histogram()
  })
}
shinyApp(ui = ui, server = server)
