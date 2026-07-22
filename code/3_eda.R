# 03_eda.R
# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to docs/ for inclusion in report.qmd.

library(tidyverse)
library(here)
library(skimr)
library(naniar)
library(visdat)

data <- read_csv(here("data", "processed", "ICT_data_clean.csv"))

# Overview
skim(data) # odd histogram of OBS_VALUE is caused by the mixture of % Values and
           # absolute counts in that column

# Check structure
glimpse(data)

# Summary of missings by variable
miss_var_summary(data) # no direct missingnes

# Visualise missing pattern
vis_miss(data)

# Visualise column types
vis_dat(data)

# Plot 1 — Distribution of the outcome variable:
plot_p1 = data %>%
  filter(MEASURE == "C5B1_I") %>%
  filter(UNIT_MEASURE == "PT_POP") %>%
  ggplot(aes(x = OBS_VALUE)) +
  geom_histogram() +
  labs(
    title = "Distribution of daily or almost daily internet use rates",
    x = "OBS_VALUE (%)",
    y = "Count of observations"
  )
plot_p1
ggsave(here("images", "eda_plot_1.png"), plot_p1)

# Plot 2 — Relationship or trend relevant to a research question 1:
plot_p2 = data %>%
  filter(MEASURE == "C5A_I") %>%
  ggplot(aes(x = EDUCATION_LEVEL, y = OBS_VALUE)) +
  geom_boxplot() +
  labs(
    title = "Relationship between education level and internet usage",
    x = "Education level",
    y = "Population share (%)"
  )
plot_p2
ggsave(here("images", "eda_plot_2.png"), plot_p2)
