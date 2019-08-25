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

############## Question 6 ########################################################
possible_filters <- unique(plotting_frame$EI.Sector)
filter_values <- possible_filters[grep("^Mobile",possible_filters)]

total_emissions_motor_two_cities <- plotting_frame %>% 
  filter(EI.Sector %in% filter_values & fips %in% c('24510','06037')) %>%
  group_by(year,fips) %>% summarise(tot_em = sum(Emissions))

total_emissions_motor_two_cities <- total_emissions_motor_two_cities %>%
  mutate(Area = case_when(fips == '24510' ~ 'Baltimore City',
                          TRUE ~ 'Los Angeles Country'))

png('plot_6.png')
ggplot(data = total_emissions_motor_two_cities, aes(x = year, y = tot_em, color = Area)) + geom_line() +
  xlab('Year') + ylab('Total Emissions (tons)') + ggtitle('Total Motor Vehicle PM2.5 Emissions By Year In Baltimore and LA') +
  theme_bw()
dev.off()

## Answer: LA has seen a greater emissions change over the 10 years in question 