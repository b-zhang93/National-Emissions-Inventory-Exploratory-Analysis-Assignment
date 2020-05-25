##############################################################################
# Across the United States, how have emissions from coal combustion-related  #
# sources changed from 1999–2008?                                            #                                       #
##############################################################################

library(ggplot2)

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset SCC for coal related pollution sources
coal_index <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coal_SCC <- SCC[coal_index,]

# join NEI and coal SCC to have the coal related data in NEI 
coal_NEI <- merge(NEI, coal_SCC, by = "SCC")

# calculate totals over years
em_coal <- tapply(coal_NEI$Emissions, coal_NEI$year, sum, na.rm = T)

# creating a data frame with emissions and year as columns
coal_data <- as.data.frame(em_coal)
coal_data$year <- rownames(coal_data)
names(coal_data) <- c("emissions", "year")

# plot the data with ggplot2 and saves it to png file
png("plot4.png", width = 480, height = 480)
g <- ggplot(coal_data, aes(year, emissions, group = 1))
g + geom_point(alpha = 1/2, size = 2) +
        geom_line(col = "blue") +
        xlab("Year") +
        ylab("Total PM.25 Emissions (tons)") +
        ggtitle("Total USA Coal Related Emissions (1999-2008)")
dev.off()
