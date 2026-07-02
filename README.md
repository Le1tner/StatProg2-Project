# Project Title

**Analysis of Daily or Almost Daily Internet Use by Education, Age, Employment Status, and Income in Germany and France (2021–2025)**

## Research Questions

1.  Is education level associated with the proportion of the population that uses the internet daily or almost every day within different age groups?

2.  How does the proportion of the population using the internet daily or almost daily differ by employment status and income group in France and Germany between 2021 and 2025?

## Dataset

-   **Source:** [OECD ICT Access and Usage by Individuals](https://data-explorer.oecd.org/vis?lc=en&tm=ICT&pg=0&snb=69&df%5Bds%5D=dsDisseminateFinalDMZ&df%5Bid%5D=DSD_ICT_HH_IND%40DF_IND&df%5Bag%5D=OECD.STI.DEP&df%5Bvs%5D=1.1&dq=.A........&pd=,&to%5BTIME_PERIOD%5D=false)

    [OECD ICT Access and Usage by Individuals (pre-filtered)](https://data-explorer.oecd.org/vis?lc=en&tm=ICT&pg=0&snb=69&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_ICT_HH_IND%40DF_IND&df[ag]=OECD.STI.DEP&df[vs]=1.1&dq=DEU%2BFRA%2BUSA.A........&pd=2021,2025&to[TIME_PERIOD]=false)

-   **Licence:** OECD Terms & Conditions (Data – Section 3) “…you can extract from, download, copy, adapt, print, distribute, share and embed Data for any purpose, even for commercial use. You must give appropriate credit to the OECD…” Citation format: OECD (year), (dataset name),(data source) DOI or URL (accessed on (date)).

-   **Description:** The dataset contains information on ICT (information and communication technologies) usage among individuals across multiple indicators, such as age, sex, education level, income group, and purpose of ICT use.

    **Note:** It is important to note that a pre-filtered version of the dataset will be used in the following analysis to reduce storage size (the full dataset is over 500MB).

    The following filters will be applied:

    -   Time period: 2021–2025

    -   Reference areas: Germany, United States, France

    This pre-filtered dataset contains 42 columns and 19010 rows. Each row represents a unique combination of multiple indicators, such as age and education level, and an observed value representing a part of the population or a count of people.

## Group Members

| Name            | GitHub username |
|-----------------|-----------------|
| Felix Leitner   | Le1tner         |
| Verena Thiemler | lervvve         |
| Rafael Schörg   | LordUhu         |
| Dean Heilig     | Deanstaccount   |

## Repository Structure

```         
data/raw/        read-only raw data and licence documentation
data/processed/  cleaned data produced by code/02_clean.R
code/            numbered R scripts (1 download → 2 clean → 3 EDA → 4 analysis)
docs/            rendered Quarto website output (auto-generated, do not edit)
proposal.qmd     project proposal
report.qmd       final analysis report
```

## How to reproduce

``` r
# 1. Install dependencies
renv::restore()   # if using renv, otherwise install packages manually

# 2. Run the pipeline in order
source("code/1_download.R")
source("code/2_clean.R")
source("code/3_eda.R")
source("code/4_analysis.R")

# 3. Render the website
quarto::quarto_render()
```
