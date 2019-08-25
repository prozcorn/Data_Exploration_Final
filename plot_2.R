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

############### Question 2 ################################################################################

## Sumarize Data
total_emissions_balt <- plotting_frame %>% filter(fips == '24510') %>% group_by(year) %>% 
  summarise(tot_em = sum(Emissions))

## Make Plot
png('plot_2.png')
plot(total_emissions_balt$year,total_emissions_balt$tot_em, xlab = 'Year', 
     ylab = 'Total Emissions (tons)', lty = 1, type = 'l')
title(main = 'Total PM2.5 Emissions By Year In Baltimore')
dev.off()

## Answer: Yes the total amount of Emissions went down between 1998 and 2008 but there was a 
## spike in 2005