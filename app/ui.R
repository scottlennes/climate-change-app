## Define UI

intro_panel <- tabPanel(
  "Intro",
  
  titlePanel("Introduction"),
  
  img(src = "intro.jpg"),
  p(),
  p("This is a dashboard about climate change, which uses a Kaggle data set"),
  p(a(href = "https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data/version/2", "Link to Kaggle data"))
)

second_panel <- tabPanel(
  "Data",
  
  titlePanel("Climate Change is Real!"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    selectInput("country", "Country:", 
                c("Germany" = "Germany",
                  "U.S." = "United States",
                  "U.K." = "United Kingdom")),
    
    checkboxInput("useFahren", "Use Fahrenheit")
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    plotOutput('TempOverTime')
  )
)

ui <- navbarPage(
  "Navigator",
  intro_panel,
  second_panel
)