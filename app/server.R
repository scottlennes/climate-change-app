## Define server logic

server <- function(input, output) {

  # Country temperature over time
  CountryTemp_data = reactive({
    
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
    
    return(idt)
    
  })
  
  output$CountryTemp_plot = renderPlot({
    
    idt = CountryTemp_data()
    
    ggplot(idt, aes(x = x, y = y, color = Country)) +
      geom_point(na.rm = TRUE) +
      geom_smooth(method = "lm", formula = y ~ x, se = FALSE, na.rm = TRUE) +
      labs(title = "Temperature by Country", x = "Year", y = "Temperature") +
      theme_light() +
      theme(plot.title = element_text(face = 'bold', hjust = 0.5), legend.position = "bottom", legend.title = element_blank())
    
  })
  
  output$CountryTemp_table <- renderDataTable({
    
    idt = CountryTemp_data()
    
    if(isTruthy(input$country_plot_brush)) idt = brushedPoints(idt, input$country_plot_brush)
    
    idt %<>% select(Country, Date, TempCelsius, TempFahren)
    
    datatable(idt, rownames = FALSE, options = list(pageLength = 5, searching = FALSE, lengthChange = FALSE))
    
  })
  
  # State temperature over time
  output$StateTemp = renderPlot({
    
    idt = temp_by_state %>%
      filter(State %in% input$state,
             month(Date, label = TRUE, abbr = FALSE) %in% input$month,
             year(Date) >= input$years[1], year(Date) <= input$years[2])
    
    idt$x = idt$Date
    
    if(input$unit == "Fahrenheit") {
      idt$y = idt$TempFahren 
    } else {
      idt$y = idt$TempCelsius
    }
    
    
    ggplot(idt, aes(x = x, y = y, color = State)) +
      geom_point(na.rm = TRUE) +
      geom_smooth(method = "lm", formula = y ~ x, se = FALSE, na.rm = TRUE) +
      labs(title = "Temperature by State", x = "Year", y = "Temperature") +
      theme_light() +
      theme(plot.title = element_text(face = 'bold', hjust = 0.5), legend.position = "bottom", legend.title = element_blank())
    
  })
  
}