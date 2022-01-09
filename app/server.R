## Define server logic

server <- function(input, output) {
  
  output$TempOverTime = renderPlot({
    
    idt = data %>%
      filter(Country == input$country,
             month(Date) == 11)
    
    x = idt$Date
    
    if(input$useFahren) {
      y = idt$TempFahren 
    } else {
      y = idt$TempCelsius
    }
      
    plot(x, y)
    
    abline(lm(y ~ x))
    
  })
  
  
}