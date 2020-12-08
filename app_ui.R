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

#### Bar Chart elements ####
pf_identity_list <- c("Legal",
                      "Same_Sex",
                      "Same_Sex_Female",
                      "Same_Sex_Male",
                      "Divorce")

# define user input for bar chart data
identity_input <- selectInput(
  inputId = "identity_input",
  label = "Choose a personal freedom identity index",
  choices = pf_identity_list
)

# define user input for bar chart year
year_bar_input <- selectInput(
  inputId = "year_bar_input",
  label = "Choose a year",
  choices = 2008:2017,
  selected = 2017
)

# define side bar content for bar chart tab
bar_sidebar_content <- sidebarPanel(
  identity_input,
  year_bar_input
)
bar_main_content <- mainPanel(
  plotlyOutput("bar")
)

#### Mapping elements ####
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

interactive_1 <- tabPanel(
  "Bar Chart",
  titlePanel("Identity Index By Region"),
  sidebarLayout(
    bar_sidebar_content,
    bar_main_content
  )
)

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
  interactive_1,
  interactive_2
  #interactive_3,
  #summary
)