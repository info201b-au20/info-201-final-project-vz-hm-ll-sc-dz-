library(tidyverse)
library(RColorBrewer)

hfi_2019_data <- read.csv("scripts/hfi_cc_2019_copy.csv")

#pf = personal freedom
pf_data <- hfi_2019_data %>%
  select(year, countries, region, pf_score)

pf_data_by_region <- pf_data %>%
  arrange(-year, region)
  
ef_data <- hfi_2019_data %>%
  select(year, countries, region, ef_score)

ef_data_by_region <- ef_data %>%
  arrange(-year, region)

total_data <- pf_data_by_region %>%
  mutate(ef_score = ef_data_by_region$ef_score)

total_data_2017 <- total_data %>%
  filter(year == max(year))

total_data_2017$ef_score <- as.numeric(as.character(total_data_2017$ef_score))
total_data_2017$pf_score <- as.numeric(as.character(total_data_2017$pf_score))


ggplot(data = total_data_2017) +
  geom_point(
    mapping = aes(x = pf_score, y = ef_score, color = region), size = 2.5
    ) +
    scale_color_brewer(palette = "Set3") +
  scale_x_continuous(limits = c(2, 10), breaks = c(2, 4, 6, 8, 10)) +
  scale_y_continuous(limits = c(2, 10), breaks = c(2, 4, 6, 8, 10)) +
  labs(
    title = paste("Personal and Economic Freedom 2017"),
    x = "Personal Freedom",
    y = "Economic Freedom")

ggsave(filename = "pf and ef scatterplot.png",
       device = "png",
       width = 15)

#ggplot(data = total_data) +
#  geom_point(
#    mapping = aes(x = pf_score, y = ef_score, color = region)
#  ) +
#  scale_color_brewer(palette = "Set3") + facet_wrap(~year) +
#  labs(
#    title = paste("Personal and Economic Freedom"),
#    x = "Personal Freedom",
#    y = "Economic Freedom")