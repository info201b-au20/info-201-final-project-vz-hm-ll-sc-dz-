# server.R
library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)

# import human freedom index data
hfi <- read.csv("scripts/hfi_cc_2019_copy.csv",
                header = TRUE,
                stringsAsFactors = FALSE,
                na.strings = c("-", "NA")
)

#### Code for Map Visual ####

# convert year to character
hfi$year <- as.character(hfi$year)

# convert hf score to numeric
col_names <- colnames(hfi)
cols.num <- col_names[col_names != "ISO_code" &
                        col_names != "countries" &
                        col_names != "year" &
                        col_names != "region"]
#hfi$hf_score <- as.numeric(as.character(hfi$hf_score))
hfi[cols.num] <- sapply(hfi[cols.num],as.numeric)
sapply(hfi, class)
# update outdated ISO code
hfi$ISO_code[hfi$ISO_code == "BRD"] <- "DEU"

#Map Functions
build_map <- function(data, map.var) {
  # specify some map projection/options
  g <- list(
    scope = "world",
    showlakes = TRUE,
    lakecolor = toRGB("white")
  )
  
  # Plot
  p <- plot_geo(data) %>%
    add_trace(
      z = data[, map.var], text = ~countries, locations = ~ISO_code,
      color = data[, map.var]
    ) %>%
    colorbar(title = map.var) %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  return(p)
}

##### start shinyServer #####
server <- function(input, output) {
  pf_plot <- reactive({
    hfi %>%
      select(year, countries, ISO_code, input$mapvar) %>%
      filter(year == input$year_input)
  })
  output$map <- renderPlotly({
    return(build_map(pf_plot(), input$mapvar))
  })
}
