library(dplyr)
library(tidyverse)

# import HFI data
hfi <- read.csv("scripts/hfi_cc_2019_copy.csv", header = TRUE, stringsAsFactors = FALSE)

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

# Rank the average human freedom score, from highest to lowest, grouped by
# different regions, as of the most recent year
high_to_low_rank <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(region) %>% 
  summarise(mean_hf_score = mean(as.numeric(hf_score))) %>% 
  arrange(-mean_hf_score)

# Compare personal freedom with women freedom across different regions, as of 
# the most recent year
pf_to_wf <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(countries) %>%
  mutate(pf_wf_ratio = as.numeric(pf_score) / as.numeric(pf_ss_women))
  unique(pf_to_wf$region[pf_to_wf$pf_wf_ratio >= 1])
  unique(pf_to_wf$region[pf_to_wf$pf_wf_ratio < 1])

# Show and rank the average economic freedom across different regions, as of the 
# most recent year
ef <- hfi %>% 
  filter(year == max(year)) %>% 
  group_by(region) %>% 
  summarise(avg_ef = mean(as.numeric(ef_score))) %>% 
  arrange(-avg_ef)

