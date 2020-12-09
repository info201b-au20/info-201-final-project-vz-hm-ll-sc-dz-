library(tidyverse)
library(rworldmap)
library(RColorBrewer)

# import human freedom index data
hfi <- read.csv("scripts/hfi_cc_2019_copy.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

# take only the most current data
current <- hfi %>%
  select(year, ISO_code, countries, hf_score) %>%
  filter(year == max(year))

# convert hf score to numeric
current$hf_score <- as.numeric(as.character(current$hf_score))

# update outdated ISO code
current$ISO_code[current$ISO_code == "BRD"] <- "DEU"

# join data to map
joined <- joinCountryData2Map(current,
  joinCode = "ISO3",
  nameJoinColumn = "ISO_code",
  verbose = TRUE
)

# plot data
par(mai = c(0, 0, 0.2, 0), xaxs = "i", yaxs = "i")
colour_palette <- RColorBrewer::brewer.pal(7, "YlGnBu")
map_params <- mapCountryData(joined,
  catMethod = "fixedWidth",
  nameColumnToPlot = "hf_score",
  missingCountryCol = "white",
  addLegend = FALSE,
  mapTitle = "Freedom Index by Country - 2017",
  colourPalette = colour_palette)
do.call(addMapLegend, c(map_params, legendWidth = 0.5, legendMar = 2))
