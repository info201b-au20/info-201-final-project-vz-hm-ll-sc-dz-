library(tidyverse)
library(RColorBrewer)

setwd(getwd())
hfi <- read.csv("scripts/hfi_cc_2019_copy.csv",
                header = TRUE,
                stringsAsFactors = FALSE)

# pf = personal freedom
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

pf_identity_summary_by_region <- pf_identity_data %>%
  filter(year == max(year)) %>%
  group_by(region) %>%
  summarize(pf_identity_legal_by_region =
              mean(as.numeric(pf_identity_legal), na.rm = T),
            pf_identity_sex_female_by_region =
              mean(as.numeric(pf_identity_sex_female), na.rm = T),
            pf_identity_sex_male_by_region =
              mean(as.numeric(pf_identity_sex_male), na.rm = T),
            pf_identity_identity_divorce_by_region =
              mean(as.numeric(pf_identity_divorce), na.rm = T),
            .groups = "drop")

region <- pf_identity_summary_by_region$region
pf_identity_legal <- pf_identity_summary_by_region$pf_identity_legal_by_region
pf_identity_sex_female <-
  pf_identity_summary_by_region$pf_identity_sex_female_by_region
pf_identity_sex_male <-
  pf_identity_summary_by_region$pf_identity_sex_male_by_region
pf_identity_divorce <-
  pf_identity_summary_by_region$pf_identity_identity_divorce_by_region
df <- data.frame(region,
                 pf_identity_legal,
                 pf_identity_sex_female,
                 pf_identity_sex_male,
                 pf_identity_divorce)
df_long <- gather(df, legend, mean_index, -region)

chart1 <-
  ggplot(data = df_long, aes(x = region, y = mean_index, fill = legend)) +
  geom_col(position = position_dodge()) +
  labs(title = "Personal Freedom: Identity and Relationships in 2017",
       subtitle = "(By Region)") +
  labs(x = "Region") +
  labs(y = "Mean Index") +
  labs(fill = "PF Identity") +
  coord_flip() +
  scale_fill_manual(labels =
                       c("Divorce",
                         "Legal",
                         "Female-female",
                         "Male-male"),
                    values = brewer.pal(4, "Accent"))

ggsave(filename = "pf_identity_grouped_bar_chart.png",
       device = "png",
       width = 20)
