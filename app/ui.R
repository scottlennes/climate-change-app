## Define UI

# Intro panel ----
intro_panel <- tabPanel(
  "Intro",
  
  titlePanel("Introduction"),
  
  img(src = "intro.jpg"),
  p(),
  p("This is a dashboard about climate change that I'm using to practice R Shiny."),
  p(a(href = "https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data/version/2", "Link to Kaggle data"))
)

# Data panel ----
second_panel <- tabPanel(
  "Data",
  
  titlePanel("Data"),
  
  sidebarLayout(

    sidebarPanel(
      
      selectInput("month", "Month:", 
                  month.name,
                  selected = "January",
                  multiple = FALSE),
      
      sliderInput("years", "Years to Include:",
                  min = year(min(temp_by_country$Date)),
                  max = year(max(temp_by_country$Date)),
                  value = c(1950, 2000),
                  ticks = FALSE,
                  sep = ""),
      
      radioButtons("unit", "Unit of Measure:",
                   c("Celsius", "Fahrenheit")),
      
      strong('FOR COUNTRY GRAPH ONLY:'),
      
      selectInput("country", "Countries:", 
                  unique(temp_by_country$Country) %>% str_sort(),
                  selected = "United States",
                  multiple = TRUE),
      
      strong('FOR STATE GRAPH ONLY:'),
      
      selectInput("state", "States:", 
                  unique(temp_by_state$State) %>% str_sort(),
                  selected = "Illinois",
                  multiple = TRUE),
    ),
    
    mainPanel(
      plotOutput('CountryTemp_plot', brush = 'country_plot_brush'),
      dataTableOutput('CountryTemp_table'),
      uiOutput('StateTemp_plot')
    )
  )
  
)

# Overall UI ----
ui <- fluidPage(
  tabsetPanel(
    intro_panel,
    second_panel
    )
  )