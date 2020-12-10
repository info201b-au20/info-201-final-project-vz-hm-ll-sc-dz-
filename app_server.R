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

#### Code for Bar Chart ####
pf_identity_data <- hfi %>%
  select(year,
         countries,
         region,
         pf_identity,
         pf_identity_legal,
         pf_identity_sex,
         pf_identity_sex_female,
         pf_identity_sex_male,
         pf_identity_divorce)

# summarize data by year and region
pf_identity_summary_by_region <- pf_identity_data %>%
  group_by(year, region) %>%
  summarize(pf_identity_legal_by_region =
              mean(as.numeric(pf_identity_legal), na.rm = T),
            pf_identity_sex_by_region =
              mean(as.numeric(pf_identity_sex), na.rm = T),
            pf_identity_sex_female_by_region =
              mean(as.numeric(pf_identity_sex_female), na.rm = T),
            pf_identity_sex_male_by_region =
              mean(as.numeric(pf_identity_sex_male), na.rm = T),
            pf_identity_identity_divorce_by_region =
              mean(as.numeric(pf_identity_divorce), na.rm = T),
            .groups = "drop")

colnames(pf_identity_summary_by_region) <- c("Year",
                                             "Region",
                                             "Legal",
                                             "Same_Sex",
                                             "Same_Sex_Female",
                                             "Same_Sex_Male",
                                             "Divorce")

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

#### Code for Scatterplot ####

pf_data <- hfi %>%
  select(year, countries, region, pf_score)

ef_data <- hfi %>%
  select(year, countries, region, ef_score)

total_data <- pf_data %>%
  mutate(ef_score = ef_data$ef_score)

total_data$ef_score <- as.numeric(as.character(total_data$ef_score))
total_data$pf_score <- as.numeric(as.character(total_data$pf_score))


##### start shinyServer #####
server <- function(input, output) {
  output$bar <- renderPlotly({
    title <- paste0(input$identity_input,
                    " Index in ",
                    input$year_bar_input,
                    " by Region")
    
    plot_data <- pf_identity_summary_by_region %>%
      filter(Year == input$year_bar_input)
    
    chart <- ggplot(plot_data) +
      geom_col(mapping = aes_string(x = "Region",
                                    y = input$identity_input),
               fill = input$color_input) +
      scale_y_continuous(limits = c(0, 10)) +
      labs(title = title,
           y = paste(input$identity_input, "Index")) +
      coord_flip()
    
    ggplotly(chart)
  })
  
  pf_plot <- reactive({
    hfi %>%
      select(year, countries, ISO_code, input$mapvar) %>%
      filter(year == input$year_input)
  })
  
  output$map <- renderPlotly({
    return(build_map(pf_plot(), input$mapvar))
  })
  
  output$scatter <- renderPlotly({
    
    scatter_data <- total_data %>%
      filter(year == input$scatter_year)
    
    scatter <- ggplot(scatter_data) +
      geom_point(
        mapping = aes(x = pf_score, y = ef_score, color = region),
        size = input$size
      ) +
      scale_color_brewer(palette = "Set3") +
      scale_x_continuous(limits = c(2, 10), breaks = c(2, 4, 6, 8, 10)) +
      scale_y_continuous(limits = c(2, 10), breaks = c(2, 4, 6, 8, 10)) +
      labs(
        title = paste0("PF vs. EF in ",
                       input$scatter_year),
        x = "Personal Freedom",
        y = "Economic Freedom",
        color = "Region")
    
    ggplotly(scatter)
  })
}
