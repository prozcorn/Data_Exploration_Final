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

############## Question 3 ########################################################
## Sumarize Data
total_emissions_balt_type <- plotting_frame %>% filter(fips == '24510') %>% group_by(year,type) %>% 
  summarise(tot_em = sum(Emissions))

## Make Plot
png('plot_3.png')
ggplot(data = total_emissions_balt_type, aes(x = year, y = tot_em, color = type)) + geom_line() +
  xlab('Year') + ylab('Total Emissions (tons)') + ggtitle('Total PM2.5 Emissions By Year In Baltimore By Type') +
  theme_bw()
dev.off()

## Answer: Emissions dropped from 1998 to 2008 for Non-road, on-Road and nonPont types and increased for Point 
