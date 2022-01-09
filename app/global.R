## Run app

# Load packages and set up workspace
library(easyr)
begin()

setwd(dirname(rstudioapi::getActiveDocumentContext()[['path']]))

library(lubridate)
library(shiny)

# Load in data
load('data/source.RData')

source('ui.R')
source('server.R')

shinyApp(ui, server)