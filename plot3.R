# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions
# from 1999–2008 for Baltimore City? Which have seen increases in emissions
# from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# First, read the dataset given by the assignment
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Convert to data.table
library(data.table)
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Take sum of total emission in Baltimore, group by year
em_bal_bytype <- NEI[fips == "24510", sum(Emissions), by = list(type, year)]
setnames(em_bal_bytype, "V1", "embalbytype")

# plot the result using base system and save to png.
library(ggplot2)
png("plot3.png", bg = "transparent", width = 600, height = 480)
p <- ggplot(em_bal_bytype, aes(year, embalbytype))
p <- p + geom_point(aes(colour = type)) + geom_line(aes(colour = type))
p <- p + labs(x = "year", y = "Emissions(ton)",
              title = "Total Emission in 3 Years at Baltimore City by Type")          
p
dev.off()
