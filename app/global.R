## Run app

# Load packages and set up workspace
library(easyr)
begin()

setwd(dirname(rstudioapi::getActiveDocumentContext()[['path']]))

library(lubridate)   # for accessing day, month, year
library(stringr)     # for sorting strings alphabetically 
library(ggplot2)     # for pretty plotting
library(shiny)

# Load in data
load('data/source.RData')

source('ui.R')
source('server.R')

shinyApp(ui, server)