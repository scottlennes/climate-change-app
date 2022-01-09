## Define UI

# Intro panel ----
intro_panel <- tabPanel(
  "Intro",
  
  titlePanel("Introduction"),
  
  img(src = "intro.jpg"),
  p(),
  p("This is a dashboard about climate change, which uses a Kaggle data set"),
  p(a(href = "https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data/version/2", "Link to Kaggle data"))
)

# Data panel ----
second_panel <- tabPanel(
  "Data",
  
  titlePanel("Average Temperature by Country"),
  
  sidebarLayout(

    sidebarPanel(
      selectInput("country", "Country:", 
                  unique(data$Country) %>% str_sort(),
                  selected = "United States",
                  multiple = TRUE),
      
      radioButtons("unit", "Unit of Measure:",
                   c("Celsius", "Fahrenheit"))
    ),
    
    mainPanel(
      plotOutput('TempOverTime')
    )
  )
  
)

# Overall UI ----
ui <- navbarPage(
  "Navigator",
  intro_panel,
  second_panel
)