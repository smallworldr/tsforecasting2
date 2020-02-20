#Hyojae Joun  
#https://blog.naver.com/hyojae2000
#https://smallworld.shinyapps.io/Korea_Tourism_Inbound_Forecasting/
#hyojae.joun@gmail.com
#18 February 2020
#Reference site: https://aneesha.shinyapps.io/ShinyTimeseriesForecasting/


library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Korea Tourism Inbound Timeseries Forecasting(Jan.2010~Nov.2019) by H.J."),
  
  # Sidebar with controls to select the dataset and forecast ahead duration
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("KOREA Tourism Forecasting" = "TOT", 
                     "Asian Tourism Inbound" = "ASIA",
                     "Chinese Tourism Inbound" = "CHN",
                     "Japanese Tourism Inbound" = "JPN")),
    numericInput("ahead", "Months to Forecast Ahead:", 12),
    
    submitButton("Update View")
  ),
  
  
  
  # Show the caption and forecast plots
  mainPanel(
    h3(textOutput("caption")),
    
    tabsetPanel(
      tabPanel("Exponetial Smoothing (ETS) Forecast", plotOutput("etsForecastPlot")), 
      tabPanel("Arima Forecast", plotOutput("arimaForecastPlot")),
      tabPanel("Timeseries Decomposition", plotOutput("dcompPlot"))
    )
  )
))

