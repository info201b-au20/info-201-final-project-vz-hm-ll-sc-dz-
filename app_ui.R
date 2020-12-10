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

# define user input for color of bars
color_input <- selectInput(
  inputId = "color_input",
  label = "Choose a color",
  choices = colors(),
  selected = "skyblue4"
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
  tags$hr(),
  year_bar_input,
  tags$p(em("Note that Legal Index does not have data from 2008 to 2014.")),
  tags$hr(),
  color_input
)

# define main content for bar chart tab
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

#### Scatterplot elements ####

scatter_year <- selectInput(
  inputId = "scatter_year",
  label = "Choose a year",
  choices = 2008:2017,
  selected = 2017
)

scatter_size <- sliderInput(
  "size",
  label = "Size of points", min = 1, max = 5, value = 2
)

scatter_sidebar_content <- sidebarPanel(
  scatter_year,
  scatter_size,
  tags$p(strong("Personal Freedom"), "is the degree to which people",
         "are free to enjoy the major freedoms",
         "often referred to as civil liberties—freedom of",
         "speech, religion, association, and assembly."),
  tags$p(strong("Economic Freedom"), "is represented as the freedom ",
         "to trade or to use sound money."),
)

scatter_main_content <- mainPanel(
  plotlyOutput("scatter")
)


#### Define user interface elements ####
introduction <- tabPanel(
  'Introduction',
    tags$body(
      tags$header(
        tags$h1("Human Freedom Index Report")
      ),
      tags$hr(),
      tags$img(src = "https://api.time.com/wp-content/uploads/2020/04/dewine-ohio-protest-coronavirus.jpg"),
      tags$p("This project aims to investigate factors that shape human freedom
             across the world and how different categorical measures of human
             freedom vary from countries and continents. The Human Freedom Index
             has indicators that are related to violence, gender, sex, economic
             freedom and so on. This data is highly relevant to today's current
             topics that surround freedom movements against violence and
             discrimination. By digging depper into these factors, we want to
             answer the question of how these indexes have changed over time.",
             "We utilized data from the most recent Human Freedom Index meansures
      published in 2019, which contains information from the years 2008 to 2017.
             It includes 76 distinct indicators in the main areas of: Rule of Law,
             Security and Safety, Movement, Religion, Association, Assembly, and
             Civil Society, Expression and Information, Identity and Relationships, 
             Size of Government, Legal System and Property Rights, Access to Sound 
             Money, Freedom to Trade Internationally, Regulation of Credit, Labor, 
             and Business. The data operates under the assumption that human freedom 
             is is defined as the absence of coercive constraint and is ranked on 
             a scale from 1 (least freedom) to 10 (most freedom).")
    )
  )


interactive_1 <- tabPanel(
  "Bar Chart",
  titlePanel(tags$h1(id = "bar_header",
                     "Personal Freedom:",
                     tags$br(),
                     tags$em(id = "bar_sub_header", "Identity"))),
  tags$hr(),
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

interactive_3 <- tabPanel(
  "Scatter",
  titlePanel("Personal Freedom vs. Economic Freedom"),
  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)

summary <- tabPanel(
  "Conclusion",
  tags$body(
    tags$header(
      tags$h1("Main Takeaways") 
    ),
    tags$main(
      tags$section(
        tags$h2("Personal Freedom (By Gender):"),
        tags$p(
        "Comparing personal freedom with women
        freedom in different regions, the data indicates higher women freedom
        in Caucasus & Central Asia, Oceania and North America but those same
        regions have lower personal freedom.")),
      tags$section(
        tags$h2("human freedom index (HFI):"),
        tags$p(
        "For year 2017, the country with the highest human
        freedom index (HFI) was New Zealand and the country with the lowest HFI
        was Syria. As for the average HFI across all regions, North America
        ranks the highest, followed by Western Europe, East Asia, Oceania,
        Eastern Europe, Latin America & the Caribbean, Caucasus & Central Asia,
        South Asia, Sub-Saharan Africa, while Middle East & North Africa ranks
        the lowest.")),
      tags$section(
        tags$h2("Personal Freedom and Economic freedom:"),
        tags$p(
        "Economic freedom sometimes is a vital factor of evaluating human freedom
        in different regions. It is expected that the data implies an almost the
        same rank of economic freedom as that of human freedom, with North
        America ranks the highest, followed by Western Europe, East Asia,
        Oceania, Eastern Europe, Caucasus & Central Asia, South Asia,
        Latin America & the Caribbean, Middle East & North Africa and
        Sub-Saharan Africa the lowest."))
    )
  )
)

# combine user interface elements
ui <- navbarPage(
  includeCSS("style.css"),
  introduction,
  interactive_1,
  interactive_2,
  interactive_3,
  summary
)
