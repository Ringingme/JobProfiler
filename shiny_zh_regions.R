library(shiny)

regions <- read.csv("regions_clean.csv")

# Sample data frames
provinces <- regions %>% select(Province)
cities <- regions %>% select(Province,City)
districts <- regions %>% select(City,District)

library(shiny)
library(dplyr)

regions <- read.csv("regions_clean.csv")

# Sample data frames
provinces <- regions %>% select(Province)
cities <- regions %>% select(Province, City)
districts <- regions %>% select(City, District)

ui <- fluidPage(
  selectInput("province", "请选择您现居住的省份:", choices = c("请选择", provinces$Province)),
  selectInput("city", "请选择您现居住的选择城市:", choices = "请选择"),
  selectInput("district", "请选择您现居住的选择区:", choices = "请选择"),
  actionButton("test_button", "去测试")  # Add the button here
)

server <- function(input, output, session) {
  
  observeEvent(input$province, {
    selected_province <- input$province
    updateSelectInput(session, "city", choices = c("请选择", unique(cities$City[cities$Province == selected_province])))
    updateSelectInput(session, "district", choices = "请选择")  # Reset district choices
  })
  
  observeEvent(input$city, {
    # Update districts based on selected city
    updateSelectInput(session, "district", choices = c("请选择", unique(districts$District[districts$City == input$city])))
  })
  
  # Observer for the action button to redirect
  observeEvent(input$test_button, {
    # Open the URL in a new browser tab
    browseURL("https://apps.psych.ut.ee/JobProfiler/")
  })
}

shinyApp(ui, server)
