# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# First, read the dataset given by the assignment
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Convert to data.table
library(data.table)
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Identify SCC code with "coal" in short.names
coal_scc <- SCC[grepl("coal", Short.Name, ignore.case = TRUE),
                c("SCC", "Short.Name"), with = FALSE]
# Merge SCC code with coal and create a new table including these rows
nei_coalscc <- merge(NEI, coal_scc, by = "SCC")
# Take sum over emissions grouped by year
coal_em <- nei_coalscc[, sum(Emissions), by = year]
setnames(coal_em, "V1", "coalem")

# plot the result using base system and save to png.
library(ggplot2)
png("plot4.png", bg = "transparent", width = 600, height = 480)
p <- ggplot(coal_em, aes(year, coalem))
p <- p + geom_point(colour = "blue") + geom_line(colour = "blue")
p <- p + labs(x = "year", y = "Emissions (ton)",
              title = "Total Emission in 3 Years in US from Coal Source")          
p
dev.off()
