library(dplyr)
library(tidyverse)

# import HFI data
hfi <- read.csv("../hfi_cc_2019.csv", header = TRUE, stringsAsFactors = FALSE)

# Pull out the name of the country which scores the highest for human freedom,
# as of the most recent year
hf_highest <- hfi %>% 
  filter(year == max(year)) %>% 
  filter(hf_score == max(hf_score, na.rm = T)) %>% 
  pull(countries)

# Pull out the name of the country which scores the lowest for human freedom,
# as of the most recent year
hf_lowest <- hfi %>% 
  filter(year == max(year)) %>% 
  filter(hf_score != 0) %>% 
  filter(hf_score == min(hf_score, na.rm = T)) %>% 
  pull(countries)

# Calculate the average human freedom score, from highest to lowest, grouped by
# different regions, as of the most recent year. Then, pull out the region with
# the highest average human freedom score
hf_highest_region <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(region) %>% 
  summarise(mean_hf_score = mean(as.numeric(hf_score))) %>% 
  filter(mean_hf_score == max(mean_hf_score)) %>% 
  pull(region)

# Calculate and display the region with the highest women freedom, as of 
# the most recent year
wf <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(region) %>%
  summarise(mean_wf = mean(as.numeric(pf_ss_women))) %>% 
  filter(mean_wf == max(mean_wf)) %>% 
  pull(region)
 
# Calculate the average economic freedom across different regions, as of the 
# most recent year, display the region with the highest economic freedom
ef <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(region) %>% 
  summarise(avg_ef = mean(as.numeric(ef_score))) %>% 
  filter(avg_ef == max(avg_ef)) %>% 
  pull(region)

  