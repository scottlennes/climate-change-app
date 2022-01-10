## Define server logic

server <- function(input, output) {
  
  output$CountryTempOverTime = renderPlot({
    
    idt = temp_by_country %>%
      filter(Country %in% input$country,
             month(Date, label = TRUE, abbr = FALSE) %in% input$month,
             year(Date) >= input$years[1], year(Date) <= input$years[2])

    idt$x = idt$Date
    
    if(input$unit == "Fahrenheit") {
      idt$y = idt$TempFahren 
    } else {
      idt$y = idt$TempCelsius
    }

      
    ggplot(idt, aes(x = x, y = y, color = Country)) +
      geom_point(na.rm = TRUE) +
      geom_smooth(method = "lm", formula = y ~ x, se = FALSE, na.rm = TRUE) +
      labs(x = "Year", y = "Temperature")
    
  })
  
  
}