# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.
# Run once; data/raw/ is read-only after this point.

library(here)

url =  "https://sdmx.oecd.org/public/rest/data/OECD.STI.DEP,DSD_ICT_HH_IND@DF_IND,1.1/DEU+FRA+USA.A........?startPeriod=2021&endPeriod=2025&dimensionAtObservation=AllDimensions&format=csvfilewithlabels"
download.file(url, destfile = here("data", "raw", "data.csv"))

message("Raw data already present — delete data/raw/ and re-run to refresh.")