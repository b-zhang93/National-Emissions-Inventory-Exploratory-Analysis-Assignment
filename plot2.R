##################################################################################################
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from #
# 1999 to 2008? Use the base plotting system to make a plot answering this question.             #                                                   #
##################################################################################################

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")

# filter the data to only Baltimore City where fips == 24510
BC_NEI <- subset(NEI, fips == "24510")

# grouping emissions by year
em_BC <- tapply(BC_NEI$Emissions, BC_NEI$year, sum, na.rm = T)

# creating a data frame with emissions and year as columns
em_data <- as.data.frame(em_BC)
em_data$year <- rownames(em_data)
names(em_data) <- c("emissions", "year")

# plot the data
with(em_data, 
     plot(year, emissions, type = "l", xlab = "Year", ylab = "Total Emissions (tons)", 
          main = "Baltimore City Total PM2.5 Emissions 1999 - 2008", lwd =2, col = "blue" ))

# saves the plot to a PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()