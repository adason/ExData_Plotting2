# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

# First, read the dataset given by the assignment
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Convert to data.table
library(data.table)
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Take sum of total emission in Baltimore, group by year
emission_baltimore <- NEI[fips == "24510", sum(Emissions), by = year]
setnames(emission_baltimore, "V1", "baltimoreem")

# plot the result using base system and save to png.
png("plot2.png", bg = "transparent")
with(emission_baltimore,
     plot(year, baltimoreem, type = "b", col = "blue", pch = 16, lwd = 2,
          main = "Totla Emission in 3 Years at Baltimore City, Maryland",
          xlab = "Year", ylab = "Emissions(ton)")
)
dev.off()
