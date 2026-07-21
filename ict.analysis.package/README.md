# ICT Analysis Package

The goal of **ict.analysis.package** is to provide tailored helper functions for analyzing and visualizing OECD Information and Communication Technology (ICT) data.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("Le1tner/StatProg2-Project", subdir = "ict.analysis.package")
```

## What’s included

The package provides 2 functions:

1.  `make_table()` =\> Generate a Formatted Regression Table.

2.  `create_boxplot()` =\> Create Standardized Boxplots for ICT Data.

## Example

``` r
library(ict.analysis.package)

# ----------------------------------------------------------------------
# 1. Generate a Standardized Boxplot
# ----------------------------------------------------------------------
# Note: Ensure your input data is filtered to a specific indicator 
# and filter UNIT_MEASURE == "PT_POP" beforehand.

create_boxplot(
  data = sample_data,
  x_value = "EDUCATION_LEVEL",
  title = "Daily Internet Usage by Education Level",
  subtitle = "Comparing percentage of population across age groups",
  facet_var = "AGE"
)

# ----------------------------------------------------------------------
# 2. Format a Linear Regression Model into a Clean Table
# ----------------------------------------------------------------------
model <- lm(OBS_VALUE ~ EDUCATION_LEVEL * AGE, data = sample_data)

make_table(model)
```
