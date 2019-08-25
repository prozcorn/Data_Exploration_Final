## Load Libraries 
library(data.table)
library(tidyverse)
library(ggplot2)
library(lattice)

## Load Data 
emissions <- readRDS("summarySCC_PM25.rds")
sources <- readRDS("Source_Classification_Code.rds")

## Combine Frames and remove earlier frames for data space
plotting_frame <- merge(emissions,sources, by = 'SCC')
rm(emissions);rm(sources);gc()

############## Question 5 ########################################################
possible_filters <- unique(plotting_frame$EI.Sector)
filter_values <- possible_filters[grep("^Mobile",possible_filters)]

total_emissions_motor <- plotting_frame %>% filter(EI.Sector %in% filter_values & fips == '24510') %>%
  group_by(year) %>% summarise(tot_em = sum(Emissions))

## Make Plot
png('plot_5.png')
plot(total_emissions_motor$year,total_emissions_motor$tot_em, xlab = 'Year', 
     ylab = 'Total Emissions (tons)', lty = 1, type = 'l')
title(main = 'Total PM2.5 Emissions By Year From Motor Vehicles In Baltimore')
dev.off()

## Answer: Emissions dropped from 1998 to 2008 for motor vehicles from 1998 to 2008 but 
## rose from 2002 to 2008

