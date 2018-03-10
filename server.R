## FUNCTIONS

getData <- function(ngear, ncyl) {
  
  my_data <- mtcars
  
  # Segment on number of cylinders
  if( ncyl != 'ANY') {
    idx <- my_data$cyl == ncyl
    my_data <- my_data[idx,]
  }
  
  # Segment on number of gears
  if( ngear != 'ANY') {
    idx <- my_data$gear == ngear
    my_data <- my_data[idx,]
  }
  
  return(my_data)

}

plotCars <- function(my_data, my_mpg, my_qsec) {
  
  p <- ggplot(my_data, aes(x=mpg, y=qsec))          +
       geom_point()                                 +
       geom_vline(xintercept = my_mpg)              +
       geom_hline(yintercept = my_qsec)             +
       ggtitle('Motor Trend Car Road Tests 1973-74') +
       xlab('Miles per Gallon')                     +
       ylab('Seconds for Quarter-Mile')
  
  return(p)

}

selectCar <- function(my_data, my_mpg, my_qsec) {
  
  # Yes, this does assume that MPG and QSEC are comparable in terms of selection
  x <- (my_data$mpg - my_mpg)^2 + (my_data$qsec - my_qsec)^2
  idx <- order(x)
  carName <- rownames(my_data)[idx[1]]
  salesList <- c('Big Bobs Backyard',
                 'A Bit Dodgy Motors',
                 'Mum & Dad Car Sales',
                 'The Car Place',
                 'Square Deal Susan'
                 )
  carYard <- salesList[sample(1:5,1)]
  pitchType <- sample(1:5,1)
  res <- switch(pitchType,
                paste0('<i>', carYard, '</i> is the best place to buy a <b>', carName, '</b>'),
                paste0('<i>', carYard, '</i> have the best deals for your <b>', carName, '</b>'),
                paste0('Thinking of buying a <b>', carName, '</b>? Then you need to go to <i>', carYard, '</i>'),
                paste0('The only place to buy a <b>', carName, '</b> is at <i>', carYard, '</i>'),
                paste0('If you go anywhere but <i>', carYard, '</i> for your <b>', carName, '</b> you have not got the best deal')
                )
  bonusType <- sample(1:5,1)
  if( bonusType <= 2) {
    res <- paste0(res, '<br>>> Mention this site and you will get a free mirror ball for your rear-view mirror')
  }
  
  return(res)
  
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  ## REACTIVE FUNCTIONS
  
  r_getData <- reactive({
    getData(input$ngear, input$ncyl)
  })
  
  r_selectCar <- eventReactive(input$select_car, {
    selectCar(r_getData(), input$mpg, input$qsec)
  })
  
  r_plot <- reactive({
    plotCars(r_getData(), input$mpg, input$qsec)
  })
  
  ## OUTPUT FUNCTIONS
  
  output$selected_car <- renderText({ r_selectCar() })

  output$plot         <- renderPlot({ r_plot() })
  
})
