####################################################################################################
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base #
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of the   #
# years 1999, 2002, 2005, and 2008.                                                                #
####################################################################################################

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")

# grouping the total emission by year
em_year <- tapply(NEI$Emissions, NEI$year, sum, na.rm = T)

# creating a data frame with emissions and year as columns
em_data <- as.data.frame(em_year)
em_data$year <- rownames(em_data)
names(em_data) <- c("emissions", "year")

# plot the data
with(em_data, 
     plot(year, emissions, type = "l", xlab = "Year", ylab = "Total Emissions (tons)", 
          main = "USA Total PM2.5 Emissions 1999 - 2008", lwd =2, col = "blue" ))

# saves the plot to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()