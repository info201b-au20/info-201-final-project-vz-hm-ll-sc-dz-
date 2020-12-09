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
  label = "Choose an identity index",
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
  tags$p(strong("Legal"), "measures the degree to which people are free ",
         "to legally change their sex and gender."),
  tags$p(strong("Same_Sex"), "measures the extent to which sexual ",
         "relationships between same sex are legal."),
  tags$p(strong("Same_Sex_Female"), "measures the extent to which sexual ",
         "relationships between women are legal."),
  tags$p(strong("Same_Sex_Male"), "measures the extent to which sexual ",
         "relationships between men are legal."),
  tags$p(strong("Divorce"), "measures whether women and men ",
         em("1)"), " have the same legal rights to initiate divorce and ",
         em("2)"), "have the same requirements for divorce."),
  year_bar_input,
  tags$p(em("Note that Legal Index does not have data from 2008 to 2014."))
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
  choices = 2008:2017,
  selected = 2017
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
  tags$p("Inputs with the ", strong("pf"), "identifier signify personal freedom ",
         "related topics."),
  tags$p("Inputs with the ", strong("ef"), "identifier signify economic freedom ",
         "related topics."),
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
  titlePanel("Personal Freedom Identity Index"),
  sidebarLayout(
    bar_sidebar_content,
    bar_main_content
  )
)

interactive_2 <- tabPanel(
  "Map",
  titlePanel("Human Freedom Index Data"),
  sidebarLayout(
    map_sidebar_content,
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