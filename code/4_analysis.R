# **Original Research Question:** Does education level influence the 
# proportion of the population across different countries and age groups 
# that use the internet daily or almost every day within the last quarter 
# of the year? (From 2021-2025)

# **Original Analysis Plan:** First of all, we would use a boxplot to get a 
# first insight into the relationship between education level and daily or 
# almost daily internet usage. Using faceted plots, we are able to compare 
# these results across different countries and age groups. Then, a linear 
# model could be used to further examine the impact of age, education level, 
# and country.

library(tidyverse)
library(here)
library(gt)
library(broom)
library(scales)
library(ict.analysis.package)

# **Dataset Preparation:**

data = read_csv(here("data", "processed", "ICT_data_clean.csv"))

data = data %>%
  filter(EDUCATION_LEVEL != "Total") %>%
  filter(UNIT_MEASURE == "PT_POP") %>%
  filter(MEASURE == "C5B1_I") %>%
  filter(SEX == "Total") %>%
  filter(AGE != "Y16T74") %>%
  select(
    -INCOME_GROUP, -EMP_STATUS, -BREAKDOWN_V7_HH, 
    -`V7 Breakdowns households`, -REF_AREA
  ) %>%
  mutate(
    EDUCATION_LEVEL = factor(EDUCATION_LEVEL, levels = c("LO", "ME", "HI")),
    AGE = factor(AGE, levels = c("Y16T24", "Y25T54", "Y55T74"))
  )

# There were no observations for the USA for the required combination of 
# variables. Therefore, we removed the comparison between countries from 
# the research question. We also decided to remove the comparison across 
# years for two reasons: first, to narrow the scope of the research 
# question, and second, because temporal trends are better addressed in a 
# separate research question and analysis.

# **New Research Question:** Is education level associated with the 
# proportion of the population that uses the internet daily or almost 
# every day within different age groups?

# In order to address the revised research question, we slightly adjust 
# our analysis plan. Two main changes were made: `TIME_PERIOD` and `REF_AREA` 
# are no longer included in either the plot or the linear model.

# **New analysis plan:** We will regress `OBS_VALUE` (the share of the 
# population using the internet daily or almost every day) on 
# `EDUCATION_LEVEL`, `AGE`, and their interaction using linear regression. 
# We will report a coefficient table with confidence intervals and a 
# boxplot with `AGE` as facet. This addresses RQ1 because it quantifies 
# the association between education level and daily internet use and 
# assesses whether this association differs across age groups.

# **Coefficient table:**

# For studying purposes:
# tidy(linear_model, conf.int = TRUE) %>%
#   gt() %>%
#     fmt_number(decimals = 2) %>%
#     fmt_number(p.value, decimals = 3) %>%
#     cols_label(
#       term = "Term",
#       estimate = "Estimate",
#       std.error = "Std. Error",
#       statistic = "Statistic",
#       p.value = "P-Value",
#       conf.low = "Conf. Low",
#       conf.high = "Conf. High"
#     ) %>%
#     cols_align(align = "right", columns = where(is.numeric)) %>%
#     tab_header(
#       title = "Linear regression results",
#       subtitle = "Coefficient table"
#     ) %>%
#     tab_source_note("Source: OECD ICT Access and Usage by Individuals")

data_lm = data

data_lm$EDUCATION_LEVEL <- relevel(factor(data_lm$EDUCATION_LEVEL), ref = "ME")
data_lm$AGE <- relevel(factor(data_lm$AGE), ref = "Y25T54")

linear_model = lm(OBS_VALUE ~ EDUCATION_LEVEL * AGE, data = data_lm)
# summary(linear_model)

make_table(
  linear_model, 
  "Linear regression results", 
  "Coefficient table", 
  "Source: OECD ICT Access and Usage by Individuals"
)

# Instead of modelling `OBS_VALUE ~ EDUCATION_LEVEL + AGE`, we chose 
# `OBS_VALUE ~ EDUCATION_LEVEL * AGE`. The interaction term allows the 
# relationship between education level and daily or almost daily internet 
# use to vary across age groups, rather than assuming that the effect of 
# education is the same for all age groups. This enables us to assess 
# whether differences in internet use between education levels become 
# larger or smaller depending on age, which is directly relevant to our 
# research question.

# **How to read this table:**
# In a linear regression model with interaction terms, the coefficients act 
# as building blocks. To estimate the percentage of daily internet users 
# for a specific group, you start at the baseline (Intercept) and add the 
# relevant effects.
#
# The Baseline: Our reference group consists of individuals aged 25 to 54 
# with a Medium education level. In this group, an estimated 91.40 percent 
# of the population use the internet daily or almost every day.
#
# Main Effects: These show the isolated effect of changing one variable. 
# For example, moving from a Medium to a Low education level subtracts 
# 11.70 percentage points.
#
# Interaction Effects: These represent the additional effect when changing 
# both age group and education level simultaneously.
#
# Calculation Example: To estimate the proportion of daily internet users 
# for individuals aged 55 to 74 with a Low education level: 
# 91.40% - 11.70% - 20.66% - 5.29% = 53.75%

# **Interpretation:**
# The linear model reveals that the relationship between education level 
# and daily internet usage is heavily moderated by age. Overall, three 
# main takeaways can be observed:
#
# 1. **Baseline and Main Trends:** Among middle-aged adults (25–54 years), 
#    lower education significantly decreases daily internet usage by 11.70 
#    percentage points (p < 0.001), while higher education increases it by 
#    5.41 percentage points (p = 0.004). Older age (55–74 years) generally 
#    leads to a sharp decline in usage across all education levels (-20.66 
#    percentage points, p < 0.001), while younger age has a positive effect 
#    (+4.93 percentage points, p = 0.009). All of these main effects are 
#    statistically significant.
#
# 2. **Education Promotes Daily Internet Usage Among Older Individuals:** 
#    Higher education serves as a strong catalyst for daily or almost daily 
#    internet usage among older adults. The interaction term 
#    (`EDUCATION_LEVELHI:AGEY55T74`) is highly impactful and statistically 
#    significant (+11.53 percentage points, p < 0.001), meaning that 
#    obtaining a high level of education eliminates more than half of the 
#    age-related drop in daily internet use. Conversely, low education 
#    further increases this gap (-5.29 percentage points, p = 0.046), 
#    although this effect is slightly less statistically significant.
#
# 3. **Education Plays Little to No Role for Young People:** For young 
#    people (16–24 years), formal education plays almost no role in daily 
#    internet access. While low education shows a positive interaction term 
#    (+9.19 percentage points, p < 0.001) that neutralizes the main 
#    low-education penalty, the high-education interaction 
#    (EDUCATION_LEVELHI:AGEY16T24) is not statistically significant 
#    (p = 0.177). Therefore, compared to the reference group, having a 
#    high level of education provides no statistically provable difference 
#    in daily internet usage for young individuals.

# **Box-Plot:**

# For studying purposes:
# plot = data_plot %>%
#   ggplot(
#     aes(x = factor(`Education Level`),
#         y = OBS_VALUE)
#   ) + 
#   geom_boxplot() +
#   facet_wrap(~ AGE) +
#   theme_bw() +
#   labs(
#     y = "Part of the population",
#     x = "Education Level",
#     title = "Daily or almost daily internet use by education level across age groups",
#     subtitle = "Daily internet use tends to increase with education level in all age groups,\nwith larger differences observed among older age groups.",
#     caption = "Source: OECD ICT Access and Usage by Individuals",
#   ) +
#   scale_y_continuous(
#     labels = label_number(suffix = "%"))
# 
# plot

data_plot = data %>%
  mutate(
    EDUCATION_LEVEL = fct_recode(
      EDUCATION_LEVEL,
      "High" = "HI",
      "Medium" = "ME",
      "Low" = "LO"
    )
  ) %>%
  mutate(
    AGE = fct_recode(
      AGE,
      "55 - 74" = "Y55T74",
      "25 - 54" = "Y25T54",
      "16 - 24" = "Y16T24"
    )
  ) %>%
  rename("Education Level" = EDUCATION_LEVEL)

#| fig-alt: "Boxplots comparing daily internet use across low, medium, and high 
#| education levels for three age groups (16–24, 25–54, and 55–74 years). Daily 
#| internet use generally increases with education level in every age group, and 
#| the differences between education levels become larger in older age groups."

create_boxplot(
  data_plot, 
  "Education Level", 
  "Daily or almost daily internet use by education level across age groups", 
  "Daily internet use tends to increase with education level in all age groups,\nwith larger differences observed among older age groups.", 
  "AGE"
)

# **Interpretation:**
# The boxplots reflect the core findings of the model and visually 
# demonstrate how daily internet usage varies across education levels and 
# age groups:
#
# - **Youngest Age Group (16–24 years):** Median daily internet usage is 
#   consistently high across all education levels, although a minor 
#   educational gradient is visible, with narrow boxes indicating very 
#   little variation between individuals.
#
# - **Middle-Aged Adults (25–54 years):** A clear educational gradient 
#   appears: median usage increases step-by-step from low to high 
#   education, with wider boxes for low and medium education, which then 
#   narrow significantly at the highest level.
#
# - **Older Adults (55–74 years):** This pattern is most pronounced in the 
#   oldest demographic, which exhibits the steepest educational gradient, 
#   the widest gap between low and high education, and the largest overall 
#   spread in the data (widest boxes).
#
# Overall, the plot confirms that higher education acts as a critical 
# buffer against infrequent or non-existent daily internet usage in older 
# age, whereas young individuals exhibit near-universal daily usage 
# regardless of their educational background.