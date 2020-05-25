############################################################################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor # 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has      #
# seen greater changes over time in motor vehicle emissions?                               #
############################################################################################

library(ggplot2)

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter the data to only Baltimore City and Los Angeles
city_NEI <- subset(NEI, fips == "24510" | fips == "06037")

# subset SCC for vehicle related pollution sources (assumption: indicated in EI Sector only)
veh_index <- grepl("vehicles", SCC$EI.Sector, ignore.case=TRUE)
veh_SCC <- SCC[veh_index,]

# join NEI and vehicle SCC to have the vehicle related data in NEI 
veh_NEI <- merge(city_NEI, veh_SCC, by = "SCC")

# creates a data frame that groups years and city and sums the emissions
veh_data <- aggregate(Emissions~year + fips, veh_NEI, sum)
names(veh_data) <- c("year", "city", "emissions")

# overwriting fips with actual city names (Baltimore and Los Angeles)
veh_data[["city"]] <- factor(veh_data[["city"]],
                                   levels = c("24510","06037"),
                                   labels = c("Baltimore", "Los Angeles"))

# plot the data with ggplot2 and saves it to png file
png("plot6.png", width = 600, height = 480)
g <- ggplot(veh_data, aes(year, emissions, color = city))
g + geom_point(alpha = 1/2, size = 2) +
        geom_line() +
        facet_wrap(.~city) +
        geom_text(aes(label=round(emissions,0)), vjust = -1, size = 3) +
        xlab("Year") +
        ylab("Total PM.25 Emissions (tons)") +
        ggtitle("Total Vehicle Related Emissions (1999-2008)")
dev.off()