library(shiny)
library(DT)
library(sf)
library(tmap)
library(ggplot2)
library(s2)

tmap_options(check.and.fix = T)
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
  ggplot(bluebikesDocksFinder())+
    geom_histogram( aes(x=Total_dock), color="darkblue", fill="lightblue", bins = 30)+
    xlab("Total docks")+ylab("density")
  
  })

bluebikes1 = data.frame(bluebikes)

output$data <-DT::renderDataTable(datatable(
    bluebikes1[,-9],filter = 'top', 
    colnames = c("Number", "Name", "Latitude", "Longtitude", "District", "Public","Total Docks",
                 "ObjectID")
  ))

}
