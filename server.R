library(shiny)
library(DT)
library(sf)
library(tmap)
library(ggplot2)

bluebikes = st_read("Blue_Bike_Stations")
server <- function(input, output) {
  # assign values to `output` here

  bluebikesDocksFinder <- reactive({
    req(input$DistrictFinder)
    filter(bluebikes, District %in% input$DistrictFinder)
  })

output$my_tmap = renderTmap({
    tm_shape(bluebikes) + tm_dots()
  })  
    
output$charts <- renderPlot({
  ggplot()+
    geom_histogram(data = bluebikesDocksFinder(), aes(x=Total_dock), color="darkblue", fill="lightblue")+
    xlab("Total dock")+ylab("density")
  
  })
  


output$data <-DT::renderDataTable(datatable(
    bluebikes[-1,-2],filter = 'top', 
    colnames = c("Number", "Name", "Latitude", "Longtitude", "District", "Public","Total Docks",
                 "ObjectID")
  ))

}
