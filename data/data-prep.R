## Preps the claims run for use in the dashboard

# Load packages and set up workspace
library(easyr)
begin()

setwd(dirname(rstudioapi::getActiveDocumentContext()[['path']]))

# Read in data files
data_read = read.csv('raw-data/GlobalLandTemperaturesByCountry.csv')

# Work up data
data = data_read %>%
  select(Date = dt,
         TempCelsius = AverageTemperature,
         Country) %>%
  mutate(Date = todate(Date, min.acceptable = NA)) %>%
  filter(year(Date) > 1800)

data %<>% mutate(TempFahren = (TempCelsius * 9 / 5) + 32)

# Save data
save(data, file = '../app/data/source.RData')