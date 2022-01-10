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
  
  titlePanel("Average Temperature by Country"),
  
  sidebarLayout(

    sidebarPanel(
      selectInput("country", "Country:", 
                  unique(temp_by_country$Country) %>% str_sort(),
                  selected = "United States",
                  multiple = TRUE),
      
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
                   c("Celsius", "Fahrenheit"))
    ),
    
    mainPanel(
      plotOutput('CountryTempOverTime')
    )
  )
  
)

# Overall UI ----
ui <- navbarPage(
  "Navigator",
  intro_panel,
  second_panel
)