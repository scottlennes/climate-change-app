## Preps the claims run for use in the dashboard

# Load packages and set up workspace
library(easyr)
begin()

library(data.table)

setwd(dirname(rstudioapi::getActiveDocumentContext()[['path']]))

# Define functions
to_fahren = function(temp_celsius) {
  temp_fahren = (temp_celsius * 9.0 / 5) + 32
  return(temp_fahren)
}

# Read in data files
files = list.files('raw-data')
data_read = lapply(files, function(x) { fread(cc('raw-data/', x)) })
names(data_read) = files

# Work up country data
temp_by_country = data_read[["GlobalLandTemperaturesByCountry.csv"]] %>%
  select(Date = dt,
         TempCelsius = AverageTemperature,
         Country) %>%
  mutate(Date = todate(Date, min.acceptable = NA)) %>%
  filter(year(Date) >= 1850)

temp_by_country %<>% mutate(TempFahren = to_fahren(TempCelsius))

# Work up city data
temp_by_state = data_read[["GlobalLandTemperaturesByState.csv"]] %>%
  filter(Country == "United States") %>%
  select(Date = dt,
         TempCelsius = AverageTemperature,
         State) %>%
  mutate(Date = todate(Date, min.acceptable = NA)) %>%
  filter(year(Date) >= 1850)

temp_by_state %<>% mutate(TempFahren = to_fahren(TempCelsius))

# Save data
save(temp_by_country, temp_by_state, file = '../app/data/source.RData')
