library(shiny)
library(ggplot2)

buttonStyle <- 'color: blue; background-color: orange'

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Brad's Car Selector"),
  
  # can slide on mpg, hp, wt, qsec
  # can filter on cyl and gears
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("ngear",
                   label = "Choose number of gears",
                   choices = list('ANY',3,4,5)
                  ),
       selectInput("ncyl",
                   label = "Choose number of cylinders",
                   choices = list('ANY',4,6,8)
                  ),
       sliderInput("mpg",
                   label = "MPG:",
                   min = 10,
                   max = 35,
                   value = 20,
                   step = 0.1
                  ),
       sliderInput("qsec",
                   label = "Quarter mile (sec):",
                   min = 15,
                   max = 25,
                   value = 20,
                   step = 0.1
                  ),
       actionButton('select_car', 'SELECT', style=buttonStyle)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput('selected_car'),
      br(),
      plotOutput('plot')
    )
  )
))
