# app_ui.R
library(shiny)
library(ggplot2)
library(RColorBrewer)
library(plotly)

# Read in data
hfi <- read.csv("scripts/hfi_cc_2019_copy.csv",
                header = TRUE,
                stringsAsFactors = FALSE
)

# Define column names
col_names <- colnames(hfi)

### Mapping elements ####
map_list <- col_names[col_names != "ISO_code" &
                        col_names != "countries" &
                        col_names != "year" &
                        col_names != "region"]
# define user input for map year
year_input <- selectInput(
  inputId = "year_input",
  label = "Choose a year",
  choices = 2008:2018
)
# define user input for mapping variable
map_input <- selectInput(
  inputId = "mapvar",
  label = "Variable to Map",
  choices = map_list
)
# define side bar content for map tab
map_sidebar_content <- sidebarPanel(
  # An input to select variable to map
  map_input,
  year_input
)
map_main_content <- mainPanel(
  plotlyOutput("map")
)

#### Define user interface elements ####
introduction <- tabPanel(
  'introduction'
)

#interactive_1 <- tabPanel(

#)

interactive_2 <- tabPanel(
  "Map",
  titlePanel("Human Freedom Index Data"),
  # A `sidebarLayout()` that contains...
  sidebarLayout(
    # Your `map_sidebar_content`
    map_sidebar_content,
    
    # Your `map_main_content`
    map_main_content
  )  
)

#interactive_3 <- tabPanel(
  
#)

#summary <- tabPanel(
  
#)

# combine user interface elements
ui <- navbarPage(
  introduction,
  #interactive_1,
  interactive_2
  #interactive_3,
  #summary
)