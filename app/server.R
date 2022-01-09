## Define server logic

server <- function(input, output) {
  
  output$TempOverTime = renderPlot({
    
    idt = data %>%
      filter(Country %in% input$country,
             month(Date) == 11)

    idt$x = idt$Date
    
    if(input$unit == "Fahrenheit") {
      idt$y = idt$TempFahren 
    } else {
      idt$y = idt$TempCelsius
    }
      
    ggplot(idt, aes(x = x, y = y, color = Country)) +
      geom_point(na.rm = TRUE) +
      geom_smooth(method = "lm", formula = y ~ x, se = FALSE, na.rm = TRUE)
    
  })
  
  
}