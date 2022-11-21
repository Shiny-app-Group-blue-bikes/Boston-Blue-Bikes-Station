library(jpeg)
library(DT)
library(dplyr)
library(tmap)

button_color_css <- "
#DivCompClear, #FinderClear, #EnterTimes{
/* Change the background color of the update button
to blue. */
background: DodgerBlue;
/* Change the text size to 15 pixels. */
font-size: 15px;
}"

intro_panel <- tabPanel(
  "Introduction", icon = icon("fa-sharp fa-solid fa-house"),
  
  titlePanel("Maps of Boston Blue Bikes"),
  
  img(src = "https://pbs.twimg.com/profile_images/1060515868860432384/Ki4uV-7l_400x400.jpg"),
  
  p("This is a 615 project of R shiny app. Our group designs an app to map the blue bikes in Boston and give the information about blue bikes station of Boston. Our group members are Kaiwei Xiao, Zijia Wang and Xiaoyanbing Cai."),
  p(a(href = "https://bostonopendata-boston.opendata.arcgis.com/datasets/boston::blue-bike-stations.zip?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D", "Data Resource"))
)
second_panel <- tabPanel("Map",icon = icon("globe-americas"),tmapOutput("my_tmap"))
third_panel <- tabPanel("Blue Bikes",fluid = TRUE, icon = icon("chart-bar"),
                         tags$style(button_color_css),
                         # Sidebar layout with a input and output definitions
                         sidebarLayout(
                           sidebarPanel(
                             titlePanel("Histograms of Total Docks by District"),
                             #shinythemes::themeSelector(),
                             fluidRow(column(3,
                                             
                                             # Select which District to plot
                                             checkboxGroupInput(inputId = "DistrictFinder",
                                                                label = "Select District(s):",
                                                                choices = c("Boston" = "Boston", "Salem" = "Salem","Cambridge" = "Cambridge", "Somerville" = "Somerville", "Brookline" = "Brookline", "Revere" = "Revere",  "Everett" = "Everett", "Arlington" = "Arlington", "Medford" = "Medfor", "Newton" = "Newton",  "Watertown" = "Watertown", "Malden" = "Malden", "Chelsea" = "Chelse"),
                                                                selected = c("Boston" = "Boston", "Salem" = "Salem","Cambridge" = "Cambridge", "Somerville" = "Somerville", "Brookline" = "Brookline", "Revere" = "Revere",  "Everett" = "Everett", "Arlington" = "Arlington", "Medford" = "Medfor", "Newton" = "Newton",  "Watertown" = "Watertown", "Malden" = "Malden", "Chelsea" = "Chelse"))))),
                           mainPanel(plotOutput("charts"))
                         ))



fourth_panel <- tabPanel("Data", DT::dataTableOutput("data"),icon = icon("table"))

ui <- navbarPage(
  "615 SHINY",
  intro_panel,
  second_panel,
  third_panel,
  fourth_panel
)

