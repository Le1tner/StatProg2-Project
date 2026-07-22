# Analysis of Daily or Almost Daily Internet Use by Education and Age, in Germany and France (2021–2025)

## Research Question

1.  Is education level associated with the proportion of the population that uses the internet daily or almost every day within different age groups?

## **Dataset**

-   **Source:** [OECD ICT Access and Usage by Individuals](https://data-explorer.oecd.org/vis?lc=en&tm=ICT&pg=0&snb=69&df%5Bds%5D=dsDisseminateFinalDMZ&df%5Bid%5D=DSD_ICT_HH_IND%40DF_IND&df%5Bag%5D=OECD.STI.DEP&df%5Bvs%5D=1.1&dq=.A........&pd=,&to%5BTIME_PERIOD%5D=false) (Accessed: 16.06.2026)

    [OECD ICT Access and Usage by Individuals (pre-filtered)](https://data-explorer.oecd.org/vis?lc=en&tm=ICT&pg=0&snb=69&df%5Bds%5D=dsDisseminateFinalDMZ&df%5Bid%5D=DSD_ICT_HH_IND%40DF_IND&df%5Bag%5D=OECD.STI.DEP&df%5Bvs%5D=1.1&dq=DEU%2BFRA%2BUSA.A........&pd=2021,2025&to%5BTIME_PERIOD%5D=false) (Accessed: 16.06.2026)

-   **Licence:** OECD Terms & Conditions (Data – Section 3) “…you can extract from, download, copy, adapt, print, distribute, share and embed Data for any purpose, even for commercial use. You must give appropriate credit to the OECD…” Citation format: OECD (year), (dataset name),(data source) DOI or URL (accessed on (date)).

-   **Description:** The dataset contains information on ICT (information and communication technologies) usage among individuals across multiple indicators, such as age, sex, education level, income group, and purpose of ICT use.

-   **Correspondence table:** <https://webfs-sti.oecd.org/files/.Stat/DSD_ICT_HH_IND/indicators_hh_ind.pdf>

    **Note:** It is important to note that a pre-filtered version of the dataset will be used in the following analysis to reduce storage size (the full dataset is over 500MB). It is also important to mention that, even though the USA is included in the filter, there were no matching data points for our research question, so it is not included in this analysis.

    The following filters will be applied:

    -   Time period: 2021–2025

    -   Reference areas: Germany, United States, France

    This pre-filtered dataset contains 42 columns and 19010 rows. Each row represents a unique combination of multiple indicators, such as age and education level, and an observed value representing a part of the population or a count of people.

## **Variable dictionary:**

| **Variable** | **Type** | **Description** | **Example / Range** |
|----|----|----|----|
| AGE | \<chr\> | Age group | Y16T24 (From 16 to 24 Years) |
| EDUCATION_LEVEL | \<chr\> | Education level | HI (High level of educational attainment) |
| REF_AREA | \<chr\> | Country | DEU (Germany) |
| TIME_PERIOD | \<int\> | Time frame (years) | 2021-2025 |
| OBS_VALUE | \<dbl\> | Part of the Population in % | 0 - 100 |
| MEASURE | \<chr\> | ICT usage Indicator (see correspondence table) | C2B_I (Individuals using a computer - last 3m) |

## **Package**

Includes two helper functions for analyzing and visualizing OECD Information and Communication Technology (ICT) data.

For more information read the package `README.md` in `ict.analysis.package/`

## **Group Members**

| Name            | GitHub username |
|-----------------|-----------------|
| Felix Leitner   | Le1tner         |
| Verena Thiemler | lervvve         |
| Rafael Schörg   | LordUhu         |
| Dean Heilig     | Deanstaccount   |

## **Repository Structure**

```         
├── code/                   # Numbered R scripts (1_download.R → 2_data_cleaning.R → 3_eda.R                                                   → 4_analysis.R)
├── data/
│   ├── raw/                # Read-only raw data and licence documentation
│   └── processed/          # Cleaned data produced by code/2_data_cleaning.R
├── docs/                   # Rendered Quarto website output (auto-generated, do not edit)
├── images/                 # Saved plots and tables
├── ict.analysis.package/   # Custom R helper package
├── renv/ & renv.lock       # Dependency management for reproducible R environment
├── _quarto.yml             # Quarto website configuration
├── index.qmd               # Landing page of the website
├── proposal.qmd            # Project proposal
├── report.qmd              # Final analysis report
├── group-reflection.qmd    # Group reflection document
└── CONTRIBUTING.md         # contribution statement and AI disclosure
```

## **How to reproduce**

``` r
# 1. Install dependencies
renv::restore()   # if using renv, otherwise install packages manually

# 2. Run the pipeline in order
source("code/1_download.R")
source("code/2_data_cleaning.R")
source("code/3_eda.R")
source("code/4_analysis.R")

# 3. Render the website
quarto::quarto_render()
```
