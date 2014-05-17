# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# First, read the dataset given by the assignment
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Convert to data.table
library(data.table)
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Identify SCC code with "Mobile" in EI.Sector
mobile_scc <- SCC[grepl("Mobile", EI.Sector, ignore.case = TRUE),
                  c("SCC", "EI.Sector"), with = FALSE]
# Merge SCC code with mobile and create a new table including these rows
nei_mobilescc <- merge(NEI, mobile_scc, by = "SCC")
# Take sum over emissions grouped by year and fips
mobile_em <- nei_mobilescc[, sum(Emissions), by = list(fips, year)]
setnames(mobile_em, "V1", "mobileem")
# Modify fips from id to meaningful city name
mobile_em <- mobile_em[fips == "06037" | fips == "24510"]
mobile_em[fips == "06037", cityname := "Los Angeles County, California"]
mobile_em[fips == "24510", cityname := "Baltimore City, Maryland"]


# plot the result using ggplot2 system and save to png.
library(ggplot2)
png("plot6.png", bg = "transparent", width = 600, height = 480)
p <- ggplot(mobile_em, aes(year, mobileem))
p <- p + geom_point(aes(colour = cityname)) + geom_line(aes(colour = cityname))
p <- p + labs(x = "year", y = "Emissions (ton)",
              title = "Comparison of Total Emission in 3 Years in US from Motor Vehicle between Baltiore and Los Angeles")
p
dev.off()
