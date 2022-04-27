#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(lubridate)
library(janitor)

stock_market_data_shiny <- read_csv("cleaned_data.csv", 
                              col_types = cols(Date = col_date(format = "%Y-%m-%d")))
#stock_market_data <- read_csv("cleaned_data.csv")
stock_market_data_shiny <- stock_market_data_shiny %>% select(-1)
# now we want to make a new column for recessions. so 1 if there is a recession and 0 if there is no recession:
# I dont want data from before 1913 as that is an important date plus the index started in 1923 so do i filter from there?

#stock_market_data_shiny2 <- stock_market_data_shiny %>% filter(Date > "1913-01-01")

stock_yearly_shiny <- stock_market_data_shiny %>% mutate(year = year(Date))
# now that we have the specific years, we want to group by them and then sumamrise\

stock_yearly_shiny <- stock_yearly_shiny %>%  clean_names()
yearly_group_shiny <- stock_yearly_shiny %>% group_by(year) %>% 
  summarise(avg_price = round(mean(real_price), 2),
            avg_dividend = round(mean(real_dividend), 2),
            cpi =round(mean(consumer_price_index), 2),
            avg_earnings = round(mean(real_earnings), 2),
            cape = round(mean(pe10), 2),
            stock_price = round(mean(sp500), 2),
            longterminterest= round(mean(long_interest_rate), 2))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("S&P 500 index real price"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("color",
                        "Line Color:",
                        min = 1,
                        max = 20,
                        value = 5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      yearly_group_shiny %>% 
        ggplot(aes(x = year, y = avg_price)) +
        geom_line(color= input$color, linetype = 2, size = 1.5) +
        theme_minimal() +
        scale_fill_brewer(palette = "Set1") +
        labs(x = "Year",
             y = "Value of Index")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
