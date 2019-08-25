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

############## Question 4 ########################################################
## Sumarize Data
filter_columns <- c('Fuel Comb - Electric Generation - Coal', 'Fuel Comb - Industrial Boilers, ICEs - Coal',
                    'Fuel Comb - Comm/Institutional - Coal')
total_emissions_coal <- plotting_frame %>% filter(EI.Sector %in% filter_columns) %>%
  group_by(year) %>% summarise(tot_em = sum(Emissions))

## Make Plot
png('plot_4.png')
plot(total_emissions_coal$year,total_emissions_coal$tot_em, xlab = 'Year', 
     ylab = 'Total Emissions (tons)', lty = 1, type = 'l')
title(main = 'Total PM2.5 Emissions By Year From Coal Combustion')
dev.off()

## Answer: Emissions dropped from 1998 to 2008 for coal related combustion 
