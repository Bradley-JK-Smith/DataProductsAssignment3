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
       h4('Instructions'),
       p('Select the number of gears you want and select the number of cyclinders you want and the number of cars that match is shown AUTOMATICALLY'),
       p('Dial up the right MPG and Quarter-Mile seconds and the lines on the graph will MOVE BEFORE YOUR EYES.'),
       p('Then hit SELECT and Brad\'s Car Selector will DO THE REST.'),
       p('The right car for YOU will be displayed.'),
       br(),
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
