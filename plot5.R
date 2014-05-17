# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

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
# Take sum over emissions grouped by year
mobile_em <- nei_mobilescc[fips == "24510", sum(Emissions), by = year]
setnames(mobile_em, "V1", "mobileem")

# plot the result using base system and save to png.
library(ggplot2)
png("plot5.png", bg = "transparent", width = 600, height = 480)
p <- ggplot(mobile_em, aes(year, mobileem))
p <- p + geom_point(colour = "blue") + geom_line(colour = "blue")
p <- p + labs(x = "year", y = "Emissions (ton)",
              title = "Total Emission in 3 Years in US from Motor Vehicle in Baltiore")          
p
dev.off()
