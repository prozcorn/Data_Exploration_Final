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

######## Question 1 Code and Answer ########################################


## Sumarize Data
total_emissions <- plotting_frame %>% group_by(year) %>% summarise(tot_em = sum(Emissions))

## Make Plot
png('question_1_plot.png')
plot(total_emissions$year,total_emissions$tot_em, xlab = 'Year', 
     ylab = 'Total Emissions (tons)', lty = 1, type = 'l')
title(main = 'Total PM2.5 Emissions By Year')
dev.off()

## Answer: Yes the total amount of Emissions have been going down per year

############### Question 2 ################################################################################

