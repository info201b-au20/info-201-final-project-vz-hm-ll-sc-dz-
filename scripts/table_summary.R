library(dplyr)
library(tidyverse)

hfi <- read.csv("../hfi_cc_2019.csv", stringsAsFactors = FALSE)
# it is sometime harder to include all the countries than the regions (being smaller in amount)
# in data visualization to show trends, so my main focus here on the summary table would be on the countries.

hfi$hf_score[hfi$hf_score == "-"] <- "0" 
hfi$pf_score[hfi$pf_score == "-"] <- "0" 
hfi$ef_score[hfi$ef_score == "-"] <- "0"
hfi$pf_ss_women[hfi$pf_ss_women == "-"] <- "0" 
hfi$pf_ss_women_fgm[hfi$pf_ss_women_fgm == "-"] <- "0" 
hfi$pf_ss_women_inheritance[hfi$pf_ss_women_inheritance == "-"] <- "0" 
hfi$pf_ss_women_inheritance_daughters[hfi$pf_ss_women_inheritance_daughters == "-"] <- "0"
hfi$pf_ss_women_inheritance_widows[hfi$pf_ss_women_inheritance_widows == "-"] <- "0" 
hfi$pf_movement_women[hfi$pf_movement_women == "-"] <- "0"

# 1. Trend of overall human freedom scores across the countries
trend_overall_countries <- 
  hfi %>% 
  select(year, countries, hf_score) %>%
  group_by(countries) %>%
  mutate(hf_score = as.numeric(hf_score)) %>%
  pivot_wider(
    id_cols = c(countries),  # What column(s) will be the unique identifier?
    names_from = year, # Where do the new column names come from?
    values_from = hf_score # Where do the new column values come from?
  )

# Result: Overall human freedom score across the countries is not showing noticeable improvement
# from 2008 to 2017, some had slightly improvement while some got worse. 

# 2. Most up-todate overall human freedom scores across the region
overall_region_2017 <- 
  hfi %>% 
  select(year, region, hf_score) %>%
  filter(year == 2017) %>%
  group_by(region) %>%
  summarise(avg_hf_score = mean(as.numeric(hf_score))) %>%
  arrange(desc(avg_hf_score))

overall_region_2017 %>% pull(region)

# Result: In terms of the overall human freedom on average across the region in 2017,
# North America ranks the highest, followed by Western Europe, East Asia, Oceania, Eastern Europe,              
# Latin America & the Caribbean, Caucasus & Central Asia, South Asia, Sub-Saharan Africa,                    
# Middle East & North Africa being the lowest.


# 3. Personal freedom VS economic freedom
ef_pf <- hfi %>% 
  select(year, countries, region, pf_score, ef_score) %>%
  group_by(countries) %>%
  mutate(ef_pf_corr = as.numeric(pf_score) / as.numeric(ef_score))

unique(ef_pf$region[ef_pf$ef_pf_corr >= 1])

unique(ef_pf$region[ef_pf$ef_pf_corr < 1])

# Result: In general, Western Europe & North America countries have higher personal freedom scores,
# with some of the lowest economic freedom scores while the others are included in both cases.


# 4. Women-Specific Personal Freedom Score by Region, 2017
women_pf_2017 <- hfi %>% 
  select(year, region, pf_ss_women) %>%
  filter(year == 2017) %>%
  group_by(region) %>%
  summarise(total_pf_ss_women = sum(as.numeric(pf_ss_women))) %>%
  arrange(desc(total_pf_ss_women))

women_pf_2017 %>% pull(region)

# Result: In terms of the safety and security aspect for women across the region in 2017, Sub-Saharan Africa
# ranks the highest, followed by Latin America & the Caribbean, Eastern Europe              
# Western Europe, South Asia, Middle East & North Africa, East Asia, Caucasus & Central Asia, Oceania                     
# and North America being the lowest    


# 5. Avg Women-Specific Personal Freedom Indicator Score by Region, 2017
avg_women_pf_2017 <- hfi %>% 
  select(year, region, pf_ss_women_fgm,
         pf_ss_women_inheritance, pf_ss_women_inheritance_daughters,
         pf_ss_women_inheritance_widows, pf_movement_women) %>%
  filter(year == 2017) %>%
  group_by(region) %>%
  summarise(avg_pf_ss_women_fgm = mean(as.numeric(pf_ss_women_fgm)),
            avg_pf_ss_women_inheritance = mean(as.numeric(pf_ss_women_inheritance)),
            avg_pf_ss_women_inheritance_daughters = mean(as.numeric(pf_ss_women_inheritance_daughters)),
            avg_pf_ss_women_inheritance_widows = mean(as.numeric(pf_ss_women_inheritance_widows)),
            avg_pf_movement_women = mean(as.numeric(pf_movement_women))) %>%
  arrange(desc(avg_pf_ss_women_fgm, avg_pf_ss_women_inheritance, avg_pf_movement_women))

avg_women_pf_2017 %>% pull(region)

# Result: In terms of the Women-Specific Personal Freedom Indicator across the region on average in 2017,
# Caucasus & Central Asia ranks the highest, followed by East Asia, Eastern Europe,              
# Latin America & the Caribbean, North America, Oceania, South Asia, Western Europe,                    
# Middle East & North Africa, and Sub-Saharan Africa being the lowest
