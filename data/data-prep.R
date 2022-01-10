## Preps the claims run for use in the dashboard

# Load packages and set up workspace
library(easyr)
begin()

library(data.table)

setwd(dirname(rstudioapi::getActiveDocumentContext()[['path']]))

# Read in data files
files = list.files('raw-data')
data_read = lapply(files, function(x) { fread(cc('raw-data/', x)) })
names(data_read) = files

# Work up data
temp_by_country = data_read[["GlobalLandTemperaturesByCountry.csv"]] %>%
  select(Date = dt,
         TempCelsius = AverageTemperature,
         Country) %>%
  mutate(Date = todate(Date, min.acceptable = NA)) %>%
  filter(year(Date) >= 1850)

temp_by_country %<>% mutate(TempFahren = (TempCelsius * 9 / 5) + 32)

# Save data
save(temp_by_country, file = '../app/data/source.RData')
