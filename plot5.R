###########################################################################################
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? #
###########################################################################################

library(ggplot2)

# reading the data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter the data to only Baltimore City
BC_NEI <- subset(NEI, fips == "24510")

# subset SCC for vehicle related pollution sources (assumption: indicated in EI Sector only)
veh_index <- grepl("vehicles", SCC$EI.Sector, ignore.case=TRUE)
veh_SCC <- SCC[veh_index,]

# join NEI and vehicle SCC to have the vehicle emission related data in NEI 
veh_NEI <- merge(BC_NEI, veh_SCC, by = "SCC")

# calculate totals over years
em_veh <- tapply(veh_NEI$Emissions, veh_NEI$year, sum, na.rm = T)

# creating a data frame with emissions and year as columns
veh_data <- as.data.frame(em_veh)
veh_data$year <- rownames(veh_data)
names(veh_data) <- c("emissions", "year")

# plot the data with ggplot2 and saves it to png file
png("plot5.png", width = 480, height = 480)
g <- ggplot(veh_data, aes(year, emissions, group = 1))
g + geom_point(alpha = 1/2, size = 2) +
        geom_line(col = "blue") +
        geom_text(aes(label=round(emissions,0)), vjust = -1) +
        xlab("Year") +
        ylab("Total PM.25 Emissions (tons)") +
        ggtitle("Total Baltimore City Vehicle Related Emissions (1999-2008)")

dev.off()