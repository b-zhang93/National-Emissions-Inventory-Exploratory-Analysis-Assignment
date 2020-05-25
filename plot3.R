###################################################################################################
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, # 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? #
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make  #
# a plot answer this question.                                                                    #
###################################################################################################

library(ggplot2)

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")

# filter the data to only Baltimore City where fips == 24510
BC_NEI <- subset(NEI, fips == "24510")

# aggregates the data by year and type and finds the sum
em_data <- aggregate(Emissions~year + type, data = BC_NEI, sum)

# creates our panel of graphs, separated by each type with ggplot2 and saves it to png file
png("plot3.png", width = 600, height = 480)
g <- ggplot(em_data, aes(year, Emissions, color = type))
g + geom_point() +
        facet_wrap(.~type) +
        geom_line() +
        xlab("Year") +
        ylab("Total Emissions (tons)") +
        ggtitle("Baltimore City PM2.5 Emissions by Type (1999-2008)")
dev.off()