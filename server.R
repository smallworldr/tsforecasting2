library(shiny)
library(datasets)
library(tseries)
library(forecast)

df <- read.csv("2010_inbd.csv", header = TRUE, sep = ",")
TOT <- ts(df$TOT, start = 2010, frequency = 12)
ASIA<- ts(df$ASIA, start = 2010, frequency = 12)
CHN <- ts(df$CHN, start = 2010, frequency = 12)
JPN <- ts(df$JPN, start = 2010, frequency = 12)

shinyServer(function(input, output) {
  
  getDataset <- reactive({
    if (input$variable=="TOT")
    {
      return(TOT)
    }
    else if (input$variable=="ASIA")
    {
      return(ASIA)
    }
    else if (input$variable=="CHN")
    {
      return(CHN)
    }
    else
    {
      return(JPN)
    }
  })
  
  output$caption <- renderText({
    paste("Dataset: ", input$variable)
  })
  
  output$dcompPlot <- renderPlot({
    ds_ts <- ts(getDataset(), frequency=12)
    f <- decompose(ds_ts)
    plot(f)
  })
  
  output$arimaForecastPlot <- renderPlot({
    fit <- auto.arima(getDataset())
    plot(forecast(fit, h=input$ahead))
  })
  
  output$etsForecastPlot <- renderPlot({
    fit <- ets(getDataset())
    plot(forecast(fit, h=input$ahead))
  })
  
})